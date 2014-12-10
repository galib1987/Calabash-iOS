//
//  NJOPClient.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import Foundation;

typedef id(^ContinuationBlock)(id);

@protocol Continuable <NSObject>
- (instancetype)continueWithBlock:(ContinuationBlock)block;
@end

@protocol Task <Continuable>
- (id)result;
- (NSError *)error;
- (NSException *)exception;
- (BOOL)isCancelled;
- (BOOL)isCompleted;
@end

@class NJOPReservation;

@interface NJOPClient : NSObject
+(void)GETReservationWithInfo:(NSDictionary*)reservationInfo completion:(void(^)(NJOPReservation*reservation,NSError*error))completionHandler;
@end
