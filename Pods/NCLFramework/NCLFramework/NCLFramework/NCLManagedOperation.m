//
//  NCLScheduledOperation.m
//  NCLFramework
//
//  Created by Chad Long on 12/6/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import "NCLManagedOperation.h"
#import "NCLFramework.h"
#import "NCLNetworking.h"
#import "NCLOperationManager.h"

@interface NCLManagedOperation()

@property (nonatomic, copy) NCLOperationBlock operation;
@property (nonatomic, copy) NCLOperationSuccessBlock successBlock;
@property (nonatomic, copy) NCLOperationFailureBlock failureBlock;
@property (nonatomic) NSInteger failures;

@property (nonatomic) UIBackgroundTaskIdentifier backgroundTaskID;

@end

@implementation NCLManagedOperation

+ (id)managedOperationWithName:(NSString*)name
                repeatInterval:(enum NCLRepeatInterval)repeatInterval
                operationQueue:(enum NCLOperationQueue)operationQueue
                executionBlock:(NCLOperationBlock)executionBlock
{
    return [[NCLManagedOperation alloc] initWithName:name repeatInterval:repeatInterval operationQueue:operationQueue executionBlock:executionBlock successBlock:nil failureBlock:nil];
}

+ (id)managedOperationWithName:(NSString*)name
                repeatInterval:(enum NCLRepeatInterval)repeatInterval
                operationQueue:(enum NCLOperationQueue)operationQueue
                executionBlock:(NCLOperationBlock)executionBlock
                  successBlock:(NCLOperationSuccessBlock)successBlock
                  failureBlock:(NCLOperationFailureBlock)failureBlock
{
    return [[NCLManagedOperation alloc] initWithName:name repeatInterval:repeatInterval operationQueue:operationQueue executionBlock:executionBlock successBlock:successBlock failureBlock:failureBlock];
}

- (id)initWithName:(NSString*)name
    repeatInterval:(enum NCLRepeatInterval)repeatInterval
    operationQueue:(enum NCLOperationQueue)operationQueue
    executionBlock:(NCLOperationBlock)executionBlock
      successBlock:(NCLOperationSuccessBlock)successBlock
      failureBlock:(NCLOperationFailureBlock)failureBlock
{
    self = [super init];
    
    if (self)
    {
        if (name == nil ||
            [name isEqualToString:@""])
        {
            @throw [NSException exceptionWithName:@"Invalid Name" reason:@"A name is required for all managed operations" userInfo:nil];
        }
        else if (_repeatInterval < 0 || _repeatInterval > 4)
        {
            @throw [NSException exceptionWithName:@"Invalid Repeat Interval" reason:@"Repeat interval for managed operation is invalid" userInfo:nil];
        }
        else if (executionBlock == nil)
        {
            @throw [NSException exceptionWithName:@"Invalid Execution Block" reason:@"An execution block is required for all managed operations" userInfo:nil];
        }
        
        _managedOperationName = name;
        _repeatInterval = repeatInterval;
        _operationQueue = operationQueue;
        self.operation = executionBlock;
        self.successBlock = successBlock;
        self.failureBlock = failureBlock;
        
        self.failures = 0;
        
        self.minimumNetworkStatus = NotReachable;
        self.retries = 0;
        self.retryInterval = 5;
        
        self.shouldUpdateLastExecutionDate = NO;
        self.shouldUpdateLastExecutionForBundleVersion = NO;
        
        self.shouldSuspendWhenBackgrounded = NO;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone*)zone
{
    NCLManagedOperation *mo = [NCLManagedOperation managedOperationWithName:self.managedOperationName
                                                             repeatInterval:self.repeatInterval
                                                             operationQueue:self.operationQueue
                                                             executionBlock:self.operation
                                                               successBlock:self.successBlock
                                                               failureBlock:self.failureBlock];
    
    mo.minimumNetworkStatus = self.minimumNetworkStatus;
    mo.retries = self.retries;
    mo.retryInterval = self.retryInterval;
    
    mo.failures = self.failures;
    
    mo.shouldUpdateLastExecutionDate = self.shouldUpdateLastExecutionDate;
    mo.shouldUpdateLastExecutionForBundleVersion = self.shouldUpdateLastExecutionForBundleVersion;
    
    mo.shouldSuspendWhenBackgrounded = self.shouldSuspendWhenBackgrounded;
    
    return mo;
}

#pragma mark - app installation operations

- (NSString*)lastBundleVersionKey
{
    return [NSString stringWithFormat:@"LastBundleForOperation%@", self.managedOperationName];
}

- (BOOL)isFirstRunForBundleVersion
{
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    NSString *installedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:[self lastBundleVersionKey]];
    
    if (installedVersion == nil ||
        ![bundleVersion isEqualToString:installedVersion])
    {
        return YES;
    }
    
    return NO;
}

- (void)updateLastExecutionForBundleVersion
{
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:bundleVersion forKey:[self lastBundleVersionKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - calendar operations

- (NSString*)lastExecutionDateKey
{
    return [NSString stringWithFormat:@"LastExecutionDateForOperation%@", self.managedOperationName];
}

- (NSDate*)lastExecutionDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self lastExecutionDateKey]];
}

- (void)updateLastExecutionDate
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate new] forKey:[self lastExecutionDateKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - operation implementation

- (void)main
{
    @synchronized(self)
    {
        if ([self shouldExecute])
        {
            [self executeOperation];
        }
    }
}

#pragma mark - execution

- (BOOL)shouldExecute
{
    BOOL shouldExecute = NO;
    
    if (self.repeatInterval == RepeatIntervalAppInstallation &&
        [self isFirstRunForBundleVersion])
    {
        shouldExecute = YES;
    }
    else if (self.repeatInterval == RepeatIntervalDaily &&
             ![[self lastExecutionDate] isToday])
    {
        shouldExecute = YES;
    }
    else if (self.repeatInterval == RepeatIntervalAppActivation ||
             self.repeatInterval == RepeatIntervalOnDemand)
    {
        shouldExecute = YES;
    }
    else if (self.repeatInterval == RepeatIntervalWeekly &&
             [[self lastExecutionDate] dateComponent:NSWeekOfYearCalendarUnit] != [[NSDate new] dateComponent:NSWeekOfYearCalendarUnit])
    {
        shouldExecute = YES;
    }

    DEBUGLog(@"should execute managed operation %@?  %@", self.managedOperationName, shouldExecute ? @"YES" : @"NO");
    
    return shouldExecute;
}

- (void)executeOperation
{
    if (self.shouldSuspendWhenBackgrounded == NO)
    {
        self.backgroundTaskID = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(void)
                                 {
                                     [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskID];
                                     self.backgroundTaskID = UIBackgroundTaskInvalid;
                                 }];
    }
    
    // validate network requirements
    BOOL networkOK = self.minimumNetworkStatus == NotReachable ||
                    (self.minimumNetworkStatus == ReachableViaWWAN && [[NCLNetworking sharedInstance] hasInternetConnection]) ||
                    (self.minimumNetworkStatus == ReachableViaWiFi && [NCLNetworking sharedInstance].networkStatus == ReachableViaWiFi);
    
    if (networkOK)
    {
        // execute the block operation
        INFOLog(@"executing managed operation %@ on %@ queue...", self.managedOperationName,
                (self.operationQueue == OperationQueueMain ? @"main" : self.operationQueue == OperationQueueBackgroundSerial ? @"serial" : @"concurrent"));
        
        id result = self.operation();
        
        // process FAILURE
        BOOL isNSError = [result isKindOfClass:[NSError class]];
        
        if (isNSError ||
            ([result respondsToSelector:@selector(isEqualToNumber:)] && [result isEqualToNumber:@NO]))
        {
            BOOL isFailFastCondition = isNSError && [self isFailFastError:(NSError*)result];
            
            self.failures++;
            
            // if exceeded retries, stop trying & exceute the failure block if one exists
            if (isFailFastCondition ||
                self.failures > self.retries)
            {
                NSString *errorDescription = isNSError ? ((NSError*)result).localizedDescription : nil;
                
                INFOLog(@"managed operation %@ FAILED%@", self.managedOperationName, (errorDescription != nil ? [NSString stringWithFormat:@": %@", errorDescription] : @""));
                
                dispatch_async
                (dispatch_get_main_queue(), ^
                 {
                     if (self.failureBlock != 0)
                     {
                         if (errorDescription)
                             self.failureBlock(result);
                         else
                             self.failureBlock(nil);
                     }
                 });
            }
            // if should retry, schedule the operation to be enqueued after the retry interval
            else
            {
                INFOLog(@"managed operation %@ failed attempt %ld", self.managedOperationName, (long)self.failures);
                
                dispatch_async
                (dispatch_get_main_queue(), ^
                 {
                     NCLManagedOperation *operationCopy = [self copy];
                     [[NCLOperationManager sharedInstance] performSelector:@selector(enqueueManagedOperation:) withObject:operationCopy afterDelay:self.retryInterval];
                 });
            }
        }
        // process SUCCESS
        else
        {
            if (self.repeatInterval == RepeatIntervalAppInstallation ||
                self.shouldUpdateLastExecutionForBundleVersion)
            {
                [self updateLastExecutionForBundleVersion];
            }
            
            else if (self.repeatInterval == RepeatIntervalDaily ||
                     self.repeatInterval == RepeatIntervalWeekly ||
                     self.shouldUpdateLastExecutionDate) // applicable when manually executed by name & want the date updated
            {
                [self updateLastExecutionDate];
            }
            
            INFOLog(@"managed operation %@ completed successfully", self.managedOperationName);
            
            dispatch_async
            (dispatch_get_main_queue(), ^
             {
                 if (self.successBlock != 0)
                 {
                     self.successBlock(result);
                 }
             });
        }
    }
    else
    {
        INFOLog(@"managed operation %@ will wait for network connectivity...", self.managedOperationName);
        
        NCLManagedOperation *operationCopy = [self copy];
        [NCLOperationManager addManagedOperationWaitingOnNetwork:operationCopy];
    }

    if (self.backgroundTaskID &&
        self.backgroundTaskID != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskID];
    }
}

- (BOOL)isFailFastError:(NSError*)error
{
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive)
        return YES;
    
    if (error.code == 404 ||
        error.code == NSURLErrorUnknown ||
        error.code == NSURLErrorTimedOut ||
        error.code == NSURLErrorCannotFindHost ||
        error.code == NSURLErrorCannotConnectToHost ||
        error.code == NSURLErrorNetworkConnectionLost ||
        error.code == NSURLErrorDNSLookupFailed ||
        error.code == NSURLErrorResourceUnavailable ||
        error.code == NSURLErrorNotConnectedToInternet ||
        error.code == NSURLErrorBadServerResponse ||
        error.code == NSURLErrorFileDoesNotExist)
    {
        return NO;
    }
    else
        return YES;
}

@end
