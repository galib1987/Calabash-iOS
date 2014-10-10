//
//  NJOPLeg.h
//  Tailwind
//
//  Created by DAVID LIN on 10/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NJOPValueTransformer.h"

@interface NJOPLeg : NSObject


@property (nonatomic, strong) NSNumber* legId;// : 176657,
@property (nonatomic, strong) NSNumber* legOrderNbr;// : 1,
@property (nonatomic, strong) NSNumber* flightRuleId;// : 1,
@property (nonatomic, strong) NSNumber* flownStatus;// : 3,
@property (nonatomic, copy) NSString* flownStatusDescription;// : "Flown",
@property (nonatomic, strong) NSDecimalNumber* estimatedFlightTime;// : 1.703,
@property (nonatomic, strong) NSDecimalNumber* estimatedFlightDistanceInKM;// : 1135.3,
@property (nonatomic, strong) NSDecimalNumber* estimatedTripTime;// : 1.4,
@property (nonatomic, copy) NSNumber* noOfFuelStops;// : 0,
@property (nonatomic, copy) NSString* tailNumber;// : "N953QS",
@property (nonatomic, strong) NSNumber* tailId;// : 1009260,
@property (nonatomic, strong) NSNumber* departureFBOId;// : 4979,
@property (nonatomic, copy) NSString* departureFBOName;// : "Sun Valley Aviation, Inc. (CLOSED)",
@property (nonatomic, strong) NSNumber* departureFBOOverrideReasonCode;// : "34",
@property (nonatomic, copy) NSString* departureFBOOverrideReasonDescription;// : "CustomerPreference",
@property (nonatomic, copy) NSString* departureFBOOverrideReasonExplanation;// : "As per email from Nelson Andrade on 11.01.2014 at 12:23",
@property (nonatomic, copy) NSString* departureAirportId;// : "KSUN",
@property (nonatomic, copy) NSString* departureAirportName;// : "FRIEDMAN MEML",
@property (nonatomic, copy) NSString* departureAirportCity;// : "HAILEY",
@property (nonatomic, copy) NSString* departureAirportState;// : "ID",
@property (nonatomic, copy) NSString* departureAirportCountry;// : "USA",
@property (nonatomic, strong) NSDate* etd;// : "2003-08-09T22:00:00Z",
@property (nonatomic, strong) NSNumber* isEtdEnteredByUser;// : true,
@property (nonatomic, strong) NSDate* outTime;// : "2003-08-09T21:48:00Z",
@property (nonatomic, strong) NSDate* atd;// : "2003-08-09T21:54:00Z",
@property (nonatomic, strong) NSNumber* arrivalFBOId;// : 4405,
@property (nonatomic, copy) NSString* arrivalFBOName;// : "Cutter Aviation",
@property (nonatomic, copy) NSString* arrivalAirportId;// : "KPHX",
@property (nonatomic, copy) NSString* arrivalAirportName;// : "PHOENIX SKY HARBOR INTL",
@property (nonatomic, copy) NSString* arrivalAirportCity;// : "PHOENIX",
@property (nonatomic, copy) NSString* arrivalAirportState;// : "AZ",
@property (nonatomic, copy) NSString* arrivalAirportCountry;// : "USA",
@property (nonatomic, strong) NSDate* eta;// : "2003-08-09T23:54:00Z",
@property (nonatomic, strong) NSNumber* isEtaEnteredByUser;// : false,
@property (nonatomic, strong) NSDate* inTime;// : "2003-08-09T23:42:00Z",
@property (nonatomic, strong) NSNumber* overriddenTripTime;// : 4,
@property (nonatomic, copy) NSString* overriddenTripTimeReason;// : "ops check"

- (void)updateWithDictionaryRepresentation:(NSDictionary *)dictionaryRepresentation;

+ (instancetype)legWithDictionaryRepresentation:(NSDictionary *)dictionaryRepresentation;

@end
