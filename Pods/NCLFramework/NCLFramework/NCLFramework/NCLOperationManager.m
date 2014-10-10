//
//  NCLOperationManager.m
//  NCLFramework
//
//  Created by Chad Long on 12/13/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCLFramework.h"
#import "NCLOperationManager.h"

@interface NCLOperationManager()

@property (strong, nonatomic) NSOperationQueue *serialOperationQueue;
@property (strong, nonatomic) NSOperationQueue *concurrentOperationQueue;
@property (strong, nonatomic) NSMutableArray *operations;
@property (strong, nonatomic) NSMutableArray *operationsWaitingOnNetworkConnectivity;

@end

@implementation NCLOperationManager

+ (NCLOperationManager*)sharedInstance
{
	static dispatch_once_t pred;
	static NCLOperationManager *sharedInstance = nil;
    
	dispatch_once
    (&pred, ^
     {
         sharedInstance = [[self alloc] init];
         
         sharedInstance.operations = [NSMutableArray new];
         sharedInstance.operationsWaitingOnNetworkConnectivity = [NSMutableArray new];
         
         sharedInstance.serialOperationQueue = [[NSOperationQueue alloc] init];
         sharedInstance.serialOperationQueue.maxConcurrentOperationCount = 1;
         sharedInstance.serialOperationQueue.name = @"NCLOperationManagerSerialOperationQueue";

         sharedInstance.concurrentOperationQueue = [[NSOperationQueue alloc] init];
         sharedInstance.concurrentOperationQueue.maxConcurrentOperationCount = 3;
         sharedInstance.concurrentOperationQueue.name = @"NCLOperationManagerConcurrentOperationQueue";
         
         [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
     });
	
    return sharedInstance;
}

#pragma mark - adding managed operations

+ (void)addManagedOperationWithName:(NSString*)name
                     repeatInterval:(enum NCLRepeatInterval)repeatInterval
                     operationQueue:(enum NCLOperationQueue)operationQueue
                     executionBlock:(NCLOperationBlock)executionBlock
{
    [NCLOperationManager addManagedOperationWithName:name
                                      repeatInterval:repeatInterval
                                      operationQueue:operationQueue
                                      executionBlock:executionBlock
                                        successBlock:nil
                                        failureBlock:nil];
}

+ (void)addManagedOperationWithName:(NSString*)name
                     repeatInterval:(enum NCLRepeatInterval)repeatInterval
                     operationQueue:(enum NCLOperationQueue)operationQueue
                     executionBlock:(NCLOperationBlock)executionBlock
                       successBlock:(NCLOperationSuccessBlock)successBlock
                       failureBlock:(NCLOperationFailureBlock)failureBlock
{
    NCLManagedOperation *operation = [NCLManagedOperation managedOperationWithName:name
                                                                    repeatInterval:repeatInterval
                                                                    operationQueue:operationQueue
                                                                    executionBlock:executionBlock
                                                                      successBlock:successBlock
                                                                      failureBlock:failureBlock];
    
    [NCLOperationManager addManagedOperation:operation];
}

+ (void)addManagedOperation:(NCLManagedOperation*)operation
{
    @synchronized(self)
    {
        [[NCLOperationManager sharedInstance].operations addObject:operation];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"queuePriority" ascending:NO];
        [NCLOperationManager sharedInstance].operations = [NSMutableArray arrayWithArray:[[NCLOperationManager sharedInstance].operations sortedArrayUsingDescriptors:@[sortDescriptor]]];
    }
}

+ (void)addManagedOperationWaitingOnNetwork:(NCLManagedOperation*)operation
{
    @synchronized(self)
    {
        [[NCLOperationManager sharedInstance].operationsWaitingOnNetworkConnectivity addObject:operation];
    }
}

#pragma mark - operation management via app lifecycle

- (void)applicationDidBecomeActive
{
    // delay the initial processing slightly... some devices don't respond to network requests immediately (i.e. iPhone 5c)
    [self performBlock:^{

        // reset the list of operations that were waiting on a network connection (these are requeued on activate anyway)
        @synchronized(self)
        {
            self.operationsWaitingOnNetworkConnectivity = [NSMutableArray new];
        }
        
        // construct a fresh operation list each time the app is activated
        NSMutableArray *operations = [NSMutableArray new];
        
        @synchronized(self)
        {
            for (NCLManagedOperation *managedOperation in self.operations)
            {
                if (managedOperation.repeatInterval != RepeatIntervalOnDemand)
                {
                    [operations addObject:[managedOperation copy]];
                }
            }
        }

        // make sure we're observing network status changes (some operations will require network availability)
        [[NCLNetworking sharedInstance] startNetworkStatusNotifier];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange) name:kReachabilityChangedNotification object:nil];
        
        // enqueue the operations
        [self processOperations:[NSArray arrayWithArray:operations]];

    } afterDelay:0.3];
}

- (void)reachabilityDidChange
{
    // if the network status changed & and we have an internet connection, process the operations that were waiting on an internet connection
    if ([[NCLNetworking sharedInstance] hasInternetConnection])
    {
        NSArray *operations = nil;
        
        @synchronized(self)
        {
            operations = [NSArray arrayWithArray:self.operationsWaitingOnNetworkConnectivity];
            self.operationsWaitingOnNetworkConnectivity = [NSMutableArray new];
        }
        
        [self processOperations:operations];
    }
}

- (void)applicationWillResignActive
{
    // stop monitoring network status changes
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];

    // cancel scheduled retries
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    // cancel all pending operations in the queue
    [self.serialOperationQueue cancelAllOperations];
    [self.concurrentOperationQueue cancelAllOperations];
    
    DEBUGLog(@"canceled pending managed operations");
}

#pragma mark - enqueuing/executing operations

- (void)enqueueManagedOperation:(NCLManagedOperation*)operation
{
    [self processOperations:[NSArray arrayWithObject:operation]];
}

+ (void)enqueueManagedOperationByName:(NSString*)operationName
{
    NCLManagedOperation *managedOperation = [NCLOperationManager getManagedOperationWithName:operationName];
 
    // manually execute an operation
    if (managedOperation)
    {
        // update the last execution date if successful
        if (managedOperation.repeatInterval == RepeatIntervalDaily ||
            managedOperation.repeatInterval == RepeatIntervalWeekly)
        {
            managedOperation.shouldUpdateLastExecutionDate = YES;
        }
        else if (managedOperation.repeatInterval == RepeatIntervalAppInstallation)
        {
            managedOperation.shouldUpdateLastExecutionForBundleVersion = YES;
        }

        // force it to run regardless of the calendar or "first run" status
        managedOperation.repeatInterval = RepeatIntervalOnDemand;
        
        [[NCLOperationManager sharedInstance] processOperations:[NSArray arrayWithObject:managedOperation]];
    }
    else
    {
        INFOLog(@"WARNING: attempted execution of non-existent managed operation %@", operationName);
    }
}

+ (NCLManagedOperation*)getManagedOperationWithName:(NSString*)operationName
{
    @synchronized(self)
    {
        for (NCLManagedOperation *managedOperation in [NCLOperationManager sharedInstance].operations)
        {
            if ([managedOperation.managedOperationName isEqualToString:operationName])
            {
                return [managedOperation copy];
            }
        }
    }
    
    return nil;
}

- (void)processOperations:(NSArray*)operations
{
    // place all the operations on the queue for immediate processing
    for (NCLManagedOperation *managedOperation in operations)
    {
        if (managedOperation.operationQueue == OperationQueueMain)
        {
            [[NSOperationQueue mainQueue] addOperation:[managedOperation copy]];
        }
        else if (managedOperation.operationQueue == OperationQueueBackgroundSerial)
        {
            [self.serialOperationQueue addOperation:[managedOperation copy]];
        }
        else
        {
            [self.concurrentOperationQueue addOperation:[managedOperation copy]];
        }
    }
}

@end