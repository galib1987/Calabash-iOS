//
//  NCLAnalytics.m
//  NCLFramework
//
//  Created by Chad Long on 9/16/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import "NCLAnalytics.h"
#import "NCLAnalyticsPersistenceManager.h"
#import "Event.h"
#import "EventDetail.h"
#import "NCLURLRequest.h"
#import "NSManagedObjectContext+Utility.h"
#import "NSDate+Utility.h"

NSString * const NCLDiagnosticsAndUsageSentNotification = @"NCLDiagnosticsAndUsageSentNotification";

@interface NCLAnalytics()

@property (strong, nonatomic) NSOperationQueue *serialOperationQueue;
@property (nonatomic, strong) NCLAnalyticsEvent *appWillResignActiveEvent;
@property (nonatomic) BOOL locked;

@end

@implementation NCLAnalytics

static NSString *installDateKey = @"InstallDate";

#pragma mark - lifecycle

+ (NCLAnalytics*)sharedInstance
{
	static dispatch_once_t pred;
	static NCLAnalytics *sharedInstance = nil;
    
	dispatch_once
    (&pred, ^
     {
         sharedInstance = [[self alloc] init];
         sharedInstance.active = NO;
         sharedInstance.requiresAuthentication = YES;
         sharedInstance.basePath = @"";
         sharedInstance.port = 0;
         sharedInstance.isSecure = YES;
         sharedInstance.retentionDays = 2;
         sharedInstance.syncThreshold = 100;
         sharedInstance.httpPostThrottle = 150;
         sharedInstance.autoSync = NO;
         
         // record when app was installed
         NSDate *installDate = [[NSUserDefaults standardUserDefaults] objectForKey:installDateKey];
         
         if (!installDate)
         {
             [[NSUserDefaults standardUserDefaults] setObject:[NSDate new].description forKey:installDateKey];
             [[NSUserDefaults standardUserDefaults] synchronize];
         }
     });
	
    return sharedInstance;
}

+ (void)start
{
    if (![NCLAnalytics sharedInstance].active)
    {
        static dispatch_once_t pred;

        dispatch_once
        (&pred, ^
         {
             [[NCLAnalyticsPersistenceManager sharedInstance] mainMOC];

             // setup the serial processing queue
             [NCLAnalytics sharedInstance].serialOperationQueue = [[NSOperationQueue alloc] init];
             [NCLAnalytics sharedInstance].serialOperationQueue.maxConcurrentOperationCount = 1;
             [NCLAnalytics sharedInstance].serialOperationQueue.name = @"NCLAnalyticsSerialOperationQueue";

             // perform clean-up mx once per day
             if ([NCLAnalytics sharedInstance].active == YES)
             {
                 NCLManagedOperation *op1 = [NCLManagedOperation managedOperationWithName:@"NCLAnalyticsCleanUp"
                                                                           repeatInterval:RepeatIntervalDaily
                                                                           operationQueue:OperationQueueBackgroundSerial
                                                                           executionBlock:^id
                                             {
                                                 NSManagedObjectContext *moc = [[NCLAnalyticsPersistenceManager sharedInstance] privateMOCWithParent:nil];
                                                 
                                                 // keep the table clean... remove stale records
                                                 NSDate *removalThreshold = [NSDate dateWithTimeIntervalSinceNow:[NCLAnalytics sharedInstance].retentionDays*60*60*24*(-1)];
                                                 NSPredicate *deletePredicate = [NSPredicate predicateWithFormat:@"createdTS < %@", removalThreshold];
                                                 NSInteger records = [moc deleteAllObjectsForEntityName:@"Event" predicate:deletePredicate error:nil];
                                                 
                                                 NSError *error = nil;
                                                 
                                                 if (![moc save:&error])
                                                 {
                                                     INFOLog(@"error cleaning expired device usage: %@", error);
                                                     return @NO;
                                                 }
                                                 else
                                                 {
                                                     INFOLog(@"removed %d device usage records prior to %@", records, removalThreshold.description);
                                                     return @YES;
                                                 }
                                             }];
                 
                 [op1 setQueuePriority:NSOperationQueuePriorityVeryLow];
                 [NCLOperationManager addManagedOperation:op1];
             }

             // post usage data when on activation when in wifi
             if ([NCLAnalytics sharedInstance].active == YES &&
                 [NCLAnalytics sharedInstance].autoSync == YES &&
                 [NCLNetworking sharedInstance].networkStatus == ReachableViaWiFi)
             {
                 NCLManagedOperation *op2 = [NCLManagedOperation managedOperationWithName:@"NCLAnalyticsPostUsageData"
                                                                           repeatInterval:RepeatIntervalAppActivation
                                                                           operationQueue:OperationQueueBackgroundSerial
                                                                           executionBlock:^id
                                             {
                                                 NSManagedObjectContext *moc = [[NCLAnalyticsPersistenceManager sharedInstance] privateMOCWithParent:nil];
                                                 
                                                 if ([moc countForFetchRequestForEntityName:@"Event" predicate:nil error:nil] > [NCLAnalytics sharedInstance].syncThreshold)
                                                 {
                                                     [[NCLAnalytics sharedInstance] sendUsage:moc silentMode:YES];
                                                 }
                                                 
                                                 return @YES;
                                             }];
                 
                 [op2 setQueuePriority:NSOperationQueuePriorityVeryLow];
                 [NCLOperationManager addManagedOperation:op2];
             }

             // register for activate/inactive
             [[NSNotificationCenter defaultCenter] addObserver:[NCLAnalytics sharedInstance] selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
             [[NSNotificationCenter defaultCenter] addObserver:[NCLAnalytics sharedInstance] selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
             
             DEBUGLog(@"NCL analytics is READY");
         });
        
        [NCLAnalytics sharedInstance].active = YES;
        
        INFOLog(@"NCL analytics started...");
    }
}

+ (void)stop
{
    if ([NCLAnalytics sharedInstance].active)
    {
        INFOLog(@"NCL analytics stopped");
        
        [NCLAnalytics sharedInstance].active = NO;
    }
}

- (void)setActive:(BOOL)active
{
    _active = active;
}

- (void)applicationDidBecomeActive
{
    // begin auditing how long app is active
    NCLAnalyticsEvent *activateEvent = [NCLAnalyticsEvent eventForComponent:@"app" action:@"applicationDidBecomeActive" value:nil];
    [self addEvent:activateEvent];
    
    self.appWillResignActiveEvent = [NCLAnalyticsEvent eventForComponent:@"app" action:@"applicationWillResignActive" value:nil];
    self.appWillResignActiveEvent.createdTS = activateEvent.createdTS;
}

- (void)applicationWillResignActive
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.appWillResignActiveEvent updateElapsedTime];
    [self.appWillResignActiveEvent setCreatedTS:[NSDate new]];
    [NCLAnalytics addEvent:self.appWillResignActiveEvent];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - device usage

+ (void)sendUsage
{
    [NCLAnalytics sendUsage:YES];
}

+ (void)sendUsage:(BOOL)silentMode
{
    NSManagedObjectContext *moc = [[NCLAnalyticsPersistenceManager sharedInstance] privateMOCWithParent:nil];
    [[NCLAnalytics sharedInstance] sendUsage:moc silentMode:silentMode];
}

- (void)sendUsage:(NSManagedObjectContext*)moc silentMode:(BOOL)silentMode
{
    if ([self tryLock])
    {
        // build the JSON to be posted to the server
        NSMutableArray *moSentList = [NSMutableArray new];
        NSMutableArray *eventInfo = [NSMutableArray new];
        NSArray *events = [moc executeFetchRequestForEntityName:@"Event" predicate:nil error:nil];
        
        if (events.count > 0)
        {
            NSInteger throttle = 1;
            
            for (Event *event in events)
            {
                NSMutableDictionary *eventDict = [NSMutableDictionary new];
                [eventDict setObject:event.createdTS.description forKey:@"createdTS"];
                [eventDict setObject:event.component forKey:@"component"];
                [eventDict setObject:event.action forKey:@"action"];
                
                if (event.elapsedTime)
                    [eventDict setObject:event.elapsedTime forKey:@"elapsedTime"];
                
                if (event.errorCode && [event.errorCode integerValue] != 0)
                    [eventDict setObject:event.errorCode forKey:@"errorCode"];
                
                if (event.transactionID)
                    [eventDict setObject:event.transactionID forKey:@"transactionID"];
                
                if (event.value)
                    [eventDict setObject:event.value forKey:@"value"];
                
                if (event.eventDetail &&
                    event.eventDetail.count > 0)
                {
                    NSMutableDictionary *eventDetailDict = [NSMutableDictionary new];
                    
                    for (EventDetail *eventDetail in event.eventDetail)
                    {
                        if (eventDetail.value)
                            [eventDetailDict setObject:eventDetail.value forKey:eventDetail.key];
                    }
                    
                    if (eventDetailDict.count > 0)
                        [eventDict setObject:eventDetailDict forKey:@"eventDetail"];
                }
                
                [eventInfo addObject:eventDict];
                [moSentList addObject:[event.objectID copy]];
                
                // throttle the post into segments
                throttle++;
                
                if (self.httpPostThrottle > 0 &&
                    throttle > self.httpPostThrottle)
                {
                    break;
                }
            }
            
            // post the events to the server
            NCLURLRequest *request = [self urlRequestWithPath:@"/usage"];
            request.param = moSentList;
            request.shouldPresentAlertOnError = !silentMode;
            request.timeoutInterval = 75;
            request.shouldSuppressAnalytics = YES;
            request.shouldDisplayActivityIndicator = !silentMode;
            
            [self POST:request HTTPBody:eventInfo completionBlock:^(NSData *data, NSError *error)
            {
                if (error)
                {
                    [self unlock];
                    
                    INFOLog(@"error sending device usage: %@", error.description);
                }
                else
                {
                    INFOLog(@"device usage sent successfully");
                    
                    NSManagedObjectContext *moc2 = [[NCLAnalyticsPersistenceManager sharedInstance] privateMOCWithParent:nil];
                    
                    for (NSManagedObjectID *moID in (NSArray*)request.param)
                    {
                        NSManagedObject *mo = [moc2 existingObjectWithID:moID error:nil];
                        
                        if (mo)
                        {
                            [moc2 deleteObject:mo];
                        }
                    }
                    
                    if (![moc2 save:&error])
                    {
                        [self unlock];
                        
                        INFOLog(@"error cleaning sent device usage: %@", error);
                    }
                    else
                    {
                        [self unlock];
                        [NCLAnalytics sendUsage:silentMode];
                    }
                }
            }];
        }
        else
        {
            [self unlock];
            
            dispatch_async
            (dispatch_get_main_queue(), ^
             {
                 INFOLog(@"sending %@ notification", NCLDiagnosticsAndUsageSentNotification);
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:NCLDiagnosticsAndUsageSentNotification object:nil];
             });
        }
    }
    else
    {
        INFOLog(@"already posting usage data... canceling duplicate request");
    }
}

#pragma mark - device diagnostics

+ (void)sendDiagnostics:(NSDictionary*)additionalDiagnostics
{
    [[NCLAnalytics sharedInstance] sendDiagnostics:additionalDiagnostics silentMode:YES];
}

+ (void)sendDiagnostics:(NSDictionary*)additionalDiagnostics silentMode:(BOOL)silentMode
{
    [[NCLAnalytics sharedInstance] sendDiagnostics:additionalDiagnostics silentMode:silentMode];
}

- (void)sendDiagnostics:(NSDictionary*)additionalDiagnostics silentMode:(BOOL)silentMode
{
    NSMutableDictionary *eventDict = [NSMutableDictionary new];
    [eventDict setObject:[NSDate new].description forKey:@"createdTS"];
    [eventDict setObject:@"diagnostics" forKey:@"component"];
    [eventDict setObject:@"post" forKey:@"action"];
    [eventDict setObject:[UIDevice identifier] forKey:@"value"];

    NSMutableDictionary *deviceInfo = [NSMutableDictionary new];
    [deviceInfo setObject:[NSString stringWithFormat:@"%d", [[UIApplication sharedApplication] enabledRemoteNotificationTypes]] forKey:@"EnabledRemoteNotificationTypes"];
    [deviceInfo setObject:[NSDateFormatter dateFormatterFromFormatType:NCLDateFormatDateOnly].dateFormat forKey:@"DateFormat"];
    [deviceInfo setObject:[UIDevice modelName] forKey:@"ModelName"];
    [deviceInfo setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"AppVersion"];
    [deviceInfo setObject:[[UIDevice currentDevice] systemVersion] forKey:@"OSVersion"];
    [deviceInfo setObject:[[NSUserDefaults standardUserDefaults] objectForKey:installDateKey] forKey:installDateKey];
    [deviceInfo setObject:[UIDevice freeMemory] forKey:@"FreeMemory"];
    [deviceInfo setObject:[UIDevice freeDiskspace] forKey:@"FreeDisk"];
    [deviceInfo setObject:[NCLAnalyticsPersistenceManager sharedInstance].storeSize forKey:@"AnalyticsDBSize"];

    if (additionalDiagnostics)
    {
        [deviceInfo addEntriesFromDictionary:additionalDiagnostics];
    }

    [eventDict setObject:deviceInfo forKey:@"eventDetail"];
    
    // send diagnostics
    NCLURLRequest *request = [self urlRequestWithPath:@"/usage"];
    request.shouldPresentAlertOnError = !silentMode;
    request.shouldSuppressAnalytics = YES;
    request.shouldDisplayActivityIndicator = !silentMode;
    
    [self POST:request HTTPBody:[NSArray arrayWithObject:eventDict] completionBlock:^(NSData *data, NSError *error)
    {
        if (error)
        {
            INFOLog(@"error sending device diagnostics: %@", error.description);
        }
        else
        {
            INFOLog(@"device diagnostics sent successfully");
        }
    }];
}

#pragma mark - adding events

+ (void)addTimedEvent:(NCLAnalyticsEvent*)event
{
    if (event)
    {
        [event updateElapsedTime];
        [[NCLAnalytics sharedInstance] addEvent:event];
    }
}

+ (void)addEvent:(NCLAnalyticsEvent*)event
{
    if (event)
    {
        [[NCLAnalytics sharedInstance] addEvent:event];
    }
}

- (void)addEvent:(NCLAnalyticsEvent*)analyticsEvent
{
    if (analyticsEvent &&
        [NCLAnalytics sharedInstance].active == YES)
    {
        NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            
            NSManagedObjectContext *moc = [[NCLAnalyticsPersistenceManager sharedInstance] privateMOCWithParent:nil];
            Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc];
            event.transactionID = analyticsEvent.transactionID;
            event.component = analyticsEvent.component;
            event.action = analyticsEvent.action;
            event.value = analyticsEvent.value;
            event.createdTS = analyticsEvent.createdTS;
            event.elapsedTime = analyticsEvent.elapsedTime;
            
            if (analyticsEvent.error)
            {
                event.errorCode = [NSNumber numberWithInteger:analyticsEvent.error.code];
                
                static NSString *errorDescriptionKey = @"errorDescription";
                EventDetail *eventDetail = [NSEntityDescription insertNewObjectForEntityForName:@"EventDetail" inManagedObjectContext:moc];
                eventDetail.key = errorDescriptionKey;
                eventDetail.value = analyticsEvent.error.description;
                [event addEventDetailObject:eventDetail];
            }
            
            if (analyticsEvent.eventInfo)
            {
                for (NSString *key in analyticsEvent.eventInfo)
                {
                    EventDetail *eventDetail = [NSEntityDescription insertNewObjectForEntityForName:@"EventDetail" inManagedObjectContext:moc];
                    eventDetail.key = key;
                    eventDetail.value = [[analyticsEvent.eventInfo objectForKey:key] description];
                    [event addEventDetailObject:eventDetail];
                }
            }
            
            NSError *error = nil;
            
            if (![moc save:&error])
            {
                INFOLog(@"error saving analytics: %@", error);
            }
        }];
        
        [operation setThreadPriority:0.4]; // priority LOW, but not so low as to prevent disk access
        
        [[NCLAnalytics sharedInstance].serialOperationQueue addOperation:operation];
    }
}

+ (NSString*)descriptionForEventsWithinRecentNumberOfMinutes:(NSInteger)minutes
{
    NSManagedObjectContext *context = [[NCLAnalyticsPersistenceManager sharedInstance] privateMOCWithParent:nil];
    NSError *error = nil;
    
    NSArray *records = [context executeFetchRequestForEntityName:@"Event"
                                                       predicate:[NSPredicate predicateWithFormat:@"createdTS > %@", [NSDate dateWithTimeIntervalSinceNow:-(minutes*60)]]
                                                 sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"createdTS" ascending:NO]]
                                           returnObjectsAsFaults:NO
                                                           error:&error];
    
    NSMutableString *description = [[NSMutableString alloc] initWithString:@"created | component | action | value | error code\n"];
    
    for (Event *event in records)
    {
        [description appendString:event.description];
    }
    
    return (records.count > 0) ? description : @"";
}

# pragma mark - locking

- (BOOL)tryLock
{
    // standard API locking doesn't handle cross threading
    @synchronized(self)
    {
        if (!self.locked)
        {
            self.locked = YES;
            
            return YES;
        }
        
        return NO;
    }
}

- (void)unlock
{
    @synchronized(self)
    {
        self.locked = NO;
    }
}

@end
