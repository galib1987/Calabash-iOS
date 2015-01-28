//
//  NJOPReservation.h
//  Tailwind
//
//  Created by NetJets on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import Foundation;

@interface NJOPReservation : NSObject
@property(nonatomic, strong) NSNumber* reservationId;
@property (nonatomic, strong) NSNumber *requestId;
@property (nonatomic, strong) NSString *aircraftType;

@property(nonatomic, strong) NSTimeZone* departureTimeZone;
@property(nonatomic, strong) NSDate* departureDate;
@property(nonatomic, copy) NSString* departureTime;

@property(nonatomic, strong) NSTimeZone* arrivalTimeZone;
@property(nonatomic, strong) NSDate* arrivalDate;
@property(nonatomic, copy) NSString* arrivalTime;

@property(nonatomic, copy) NSString* departureDateString;
@property(nonatomic, copy) NSString* arrivalDateString;

@property(nonatomic, copy) NSString* arrivalAirportId;
@property(nonatomic, copy) NSString* departureAirportId;

@property(nonatomic, copy) NSString* tailNumber;

@property(nonatomic, copy) NSString* departureFboName;
@property(nonatomic, copy) NSString* arrivalFboName;

@property(nonatomic, copy) NSString* departureAirportCity;
@property(nonatomic, copy) NSString* arrivalAirportCity;

@property(nonatomic, strong) NSNumber* estimatedTripTimeNumber;
@property(nonatomic, strong) NSNumber* travelHours;
@property(nonatomic, strong) NSNumber* travelMinutes;
@property(nonatomic, copy) NSString* travelTime;

@property(nonatomic, copy) NSString* travelTimeMessage;
@property(nonatomic, strong) NSNumber* stops;
@property(nonatomic, copy) NSString* stopsText;
@property (nonatomic, copy) NSString *rawData;

@property (nonatomic, copy) NSArray *passengers;
@property (nonatomic, copy) NSArray *groundOrders;
@property (nonatomic, copy) NSArray *cateringOrders;

@end
