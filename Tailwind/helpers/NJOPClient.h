//
//  NJOPClient.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import Foundation;

@class NJOPReservation;

@interface NJOPClient : NSObject
+(void)GETReservationWithInfo:(NSDictionary*)reservationInfo completion:(void(^)(NJOPReservation*reservation,NSError*error))completionHandler;
@end
