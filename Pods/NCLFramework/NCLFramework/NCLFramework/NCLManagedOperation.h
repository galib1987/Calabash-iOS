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

typedef NS_OPTIONS(NSInteger, NCLRepeatIntervalOptions)
{
    NCLRepeatIntervalOnDemand         = 1 << 0,
    NCLRepeatIntervalAppInstallation  = 1 << 1,
    NCLRepeatIntervalWeekly           = 1 << 2,
    NCLRepeatIntervalDaily            = 1 << 3,
    NCLRepeatIntervalAppActivation    = 1 << 4
};

enum NCLOperationQueue : NSInteger
{
    NCLOperationQueueMain = 0,
    NCLOperationQueueBackgroundSerial = 1,
    NCLOperationQueueBackgroundConcurrent = 2
};

@interface NCLManagedOperation : NSOperation <NSCopying>

@property (nonatomic, readonly, strong) NSString *managedOperationName;
@property (nonatomic) NCLRepeatIntervalOptions repeatIntervalOptions;
@property (nonatomic, readonly) enum NCLOperationQueue operationQueue;

@property (nonatomic) NetworkStatus minimumNetworkStatus;
@property (nonatomic) NSInteger retries;
@property (nonatomic) NSTimeInterval retryInterval;

@property (nonatomic) BOOL shouldUpdateLastExecutionDate;
@property (nonatomic) BOOL shouldUpdateLastExecutionForBundleVersion;

@property (nonatomic) BOOL shouldSuspendWhenBackgrounded;

+ (id)managedOperationWithName:(NSString*)name
         repeatIntervalOptions:(NCLRepeatIntervalOptions)repeatIntervalOptions
                operationQueue:(enum NCLOperationQueue)operationQueue
                executionBlock:(NCLOperationBlock)executionBlock;

+ (id)managedOperationWithName:(NSString*)name
         repeatIntervalOptions:(NCLRepeatIntervalOptions)repeatInterval
                operationQueue:(enum NCLOperationQueue)operationQueue
                executionBlock:(NCLOperationBlock)executionBlock
                  successBlock:(NCLOperationSuccessBlock)successBlock
                  failureBlock:(NCLOperationFailureBlock)failureBlock;

@end