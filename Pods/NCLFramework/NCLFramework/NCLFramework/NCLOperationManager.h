//
//  NCLOperationManager.h
//  NCLFramework
//
//  Created by Chad Long on 12/13/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCLManagedOperation.h"

@interface NCLOperationManager : NSObject

+ (NCLOperationManager*)sharedInstance;

+ (void)addManagedOperationWithName:(NSString*)name
              repeatIntervalOptions:(NCLRepeatIntervalOptions)repeatIntervalOptions
                     operationQueue:(enum NCLOperationQueue)operationQueue
                     executionBlock:(NCLOperationBlock)executionBlock
                       successBlock:(NCLOperationSuccessBlock)successBlock
                       failureBlock:(NCLOperationFailureBlock)failureBlock;

+ (void)addManagedOperationWithName:(NSString*)name
              repeatIntervalOptions:(NCLRepeatIntervalOptions)repeatIntervalOptions
                     operationQueue:(enum NCLOperationQueue)operationQueue
                     executionBlock:(NCLOperationBlock)executionBlock;

+ (void)addManagedOperation:(NCLManagedOperation*)operation;
+ (void)addManagedOperationWaitingOnNetwork:(NCLManagedOperation*)operation;

- (void)enqueueManagedOperation:(NCLManagedOperation*)operation;
+ (void)enqueueManagedOperationByName:(NSString*)operationName;
+ (NCLManagedOperation*)getManagedOperationWithName:(NSString*)operationName;

@end
