//
//  NJOPClient.m
//  Tailwind
//
//  Created by NetJets on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPClient.h"
#import "NJOPReservation.h"
#import "NJOPValueTransformer.h"
#import "NSDate+NJOP.h"
#import "NSDateFormatter+Utility.h"

#import "BFTask.h"

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
	reservation.departureTime = [reservation.departureDate formattedDateWithFormat:@"hh:mma zzz" timeZone:reservation.departureTimeZone];

	reservation.arrivalTimeZone = [NSTimeZone timeZoneWithAbbreviation:representation[@"arrivalTimeZoneFormat"]];
	reservation.arrivalDate = [jsonDateFormatter dateFromString:representation[@"etaGmt"]];
	reservation.arrivalTime = [reservation.arrivalDate formattedDateWithFormat:@"hh:mma zzz" timeZone:reservation.arrivalTimeZone];

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
