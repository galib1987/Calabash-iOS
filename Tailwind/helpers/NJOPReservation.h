//
//  NJOPReservation.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJOPReservation : NSObject

@property(nonatomic, readonly) NSNumber* reservationId;

@property(nonatomic, readonly) NSTimeZone* departureTimeZone;
@property(nonatomic, readonly) NSDate* departureDate;
@property(nonatomic, readonly) NSString* departureTime;

@property(nonatomic, readonly) NSTimeZone* arrivalTimeZone;
@property(nonatomic, readonly) NSDate* arrivalDate;
@property(nonatomic, readonly) NSString* arrivalTime;

@property(nonatomic, readonly) NSString* departureDateString;
@property(nonatomic, readonly) NSString* arrivalDateString;

@property(nonatomic, readonly) NSString* arrivalAirportId;
@property(nonatomic, readonly) NSString* departureAirportId;

@property(nonatomic, readonly) NSString* tailNumber;

@property(nonatomic, readonly) NSString* departureFboName;
@property(nonatomic, readonly) NSString* arrivalFboName;

@property(nonatomic, readonly) NSString* departureAirportCity;
@property(nonatomic, readonly) NSString* arrivalAirportCity;

@property(nonatomic, readonly) NSNumber* estimatedTripTimeNumber;
@property(nonatomic, readonly) NSNumber* travelHours;
@property(nonatomic, readonly) NSNumber* travelMinutes;
@property(nonatomic, readonly) NSString* travelTime;

@property(nonatomic, readonly) NSString* travelTimeMessage;
@property(nonatomic, readonly) NSNumber* stops;
@property(nonatomic, readonly) NSString* stopsText;

@end