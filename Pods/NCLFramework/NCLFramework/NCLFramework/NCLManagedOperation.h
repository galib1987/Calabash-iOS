//
//  NCLScheduledOperation.h
//  NCLFramework
//
//  Created by Chad Long on 12/6/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

typedef id(^NCLOperationBlock)(void);
typedef void(^NCLOperationSuccessBlock)(id);
typedef void(^NCLOperationFailureBlock)(NSError*);

enum NCLRepeatInterval : NSInteger
{
    RepeatIntervalOnDemand = 0,
    RepeatIntervalAppInstallation = 1,
    RepeatIntervalWeekly = 2,
    RepeatIntervalDaily = 3,
    RepeatIntervalAppActivation = 4
};

enum NCLOperationQueue : NSInteger
{
    OperationQueueMain = 0,
    OperationQueueBackgroundSerial = 1,
    OperationQueueBackgroundConcurrent = 2
};

@interface NCLManagedOperation : NSOperation <NSCopying>

@property (nonatomic, readonly, strong) NSString *managedOperationName;
@property (nonatomic) enum NCLRepeatInterval repeatInterval;
@property (nonatomic, readonly) enum NCLOperationQueue operationQueue;

@property (nonatomic) NetworkStatus minimumNetworkStatus;
@property (nonatomic) NSInteger retries;
@property (nonatomic) NSTimeInterval retryInterval;

@property (nonatomic) BOOL shouldUpdateLastExecutionDate;
@property (nonatomic) BOOL shouldUpdateLastExecutionForBundleVersion;

@property (nonatomic) BOOL shouldSuspendWhenBackgrounded;

+ (id)managedOperationWithName:(NSString*)name
                repeatInterval:(enum NCLRepeatInterval)repeatInterval
                operationQueue:(enum NCLOperationQueue)operationQueue
                executionBlock:(NCLOperationBlock)executionBlock;

+ (id)managedOperationWithName:(NSString*)name
                repeatInterval:(enum NCLRepeatInterval)repeatInterval
                operationQueue:(enum NCLOperationQueue)operationQueue
                executionBlock:(NCLOperationBlock)executionBlock
                  successBlock:(NCLOperationSuccessBlock)successBlock
                  failureBlock:(NCLOperationFailureBlock)failureBlock;

@end