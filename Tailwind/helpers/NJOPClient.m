//
//  NJOPClient.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPClient.h"
#import "NJOPReservation.h"
#import "NJOPValueTransformer.h"
#import "NSDate+NJOP.h"

@interface NJOPReservation ()
@property(nonatomic, strong) NSNumber* reservationId;

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
@end

@interface NJOPClassDataTransformer : NJOPValueTransformer
@end

@implementation NJOPClient

+(void)GETReservationWithInfo:(NSDictionary *)reservationInfo completion:(void (^)(NJOPReservation *reservation, NSError *error))completionHandler {

	NSData* data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mobile-api-reservations-response" ofType:@"json"]];
	NSDictionary* payload = [NSJSONSerialization JSONObjectWithData:data
																													options:0
																														error:nil];
	NSDictionary* representation = [payload valueForKeyPath:@"requests"][0];

	NSString* jsonDateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
	NSDateFormatter* jsonDateFormatter = [NSDateFormatter new];
	[jsonDateFormatter setDateFormat:jsonDateFormat];

	NJOPReservation* reservation = [NJOPReservation new];

	reservation.reservationId = representation[@"reservationId"];
	reservation.departureTimeZone = [NSTimeZone timeZoneWithAbbreviation:representation[@"departureTimeZoneFormat"]];
	reservation.departureDate = [jsonDateFormatter dateFromString:representation[@"etdGmt"]];
	reservation.departureTime = [reservation.departureDate formattedDateWithFormat:@"hh:mma zzz"
																																				timeZone:reservation.departureTimeZone];

	reservation.arrivalTimeZone = [NSTimeZone timeZoneWithAbbreviation:representation[@"arrivalTimeZoneFormat"]];
	reservation.arrivalDate = [jsonDateFormatter dateFromString:representation[@"etaGmt"]];
	reservation.arrivalTime = [reservation.arrivalDate formattedDateWithFormat:@"hh:mma zzz"
																																		timeZone:reservation.arrivalTimeZone];

	reservation.departureDateString = [reservation.departureDate njop_spacialDate:@"MMM DD yyyy"
																																			 timeZone:reservation.departureTimeZone];

	reservation.arrivalDateString = [reservation.arrivalDate njop_spacialDate:@"MMM DD yyyy"
																																	 timeZone:reservation.departureTimeZone];

	reservation.arrivalAirportId = representation[@"arrivalAirportId"];
	reservation.departureAirportId = representation[@"departureAirportId"];

	reservation.tailNumber = representation[@"tailNumber"];

	reservation.departureFboName = representation[@"departureFboName"];
	reservation.arrivalFboName = representation[@"arrivalFboName"];

	reservation.departureAirportCity = representation[@"departureAirportCity"];
	reservation.arrivalAirportCity = representation[@"arrivalAirportCity"];

	reservation.estimatedTripTimeNumber = representation[@"estimatedTripTime"];
	reservation.travelHours = @(reservation.estimatedTripTimeNumber.integerValue);
	reservation.travelMinutes = @(ceilf((reservation.estimatedTripTimeNumber.floatValue - [reservation.travelHours floatValue])* 60));

	reservation.travelTime = [NSString stringWithFormat:@"%@h %@m",
														reservation.travelHours,
														reservation.travelMinutes];
	reservation.stops = @([representation[@"noOfFuelStops"] integerValue]);
	reservation.stopsText = [reservation.stops boolValue] ? @"" : @"Non Stop";

	if (completionHandler) {
		completionHandler(reservation,nil);
	}
}

@end
