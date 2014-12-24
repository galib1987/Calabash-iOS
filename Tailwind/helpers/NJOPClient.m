//
//  NJOPClient.m
//  Tailwind
//
//  Created by NetJets on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPClient.h"
#import "NJOPIndividual.h"
#import "NJOPReservation.h"
#import "NJOPValueTransformer.h"
#import "NSDate+NJOP.h"
#import "NSDateFormatter+Utility.h"
#import "NCLHTTPClient.h"

#import "NCLInfoPresenter.h"

#import "BFTask.h"

@interface NJOPClassDataTransformer : NJOPValueTransformer
@end

@implementation NJOPClient

+(void)GETReservationWithInfo:(NSDictionary *)reservationInfo completion:(void (^)(NJOPReservation *reservation, NSError *error))completionHandler {
    NSString *apiURL = @"";
    NSData *data = nil;
    NSString *jsonString = @"";
    NSError *error = nil;
    NSURLResponse *response = nil;
    if (reservationInfo != nil && [reservationInfo isKindOfClass:[NSDictionary class]]) {
        // look at the NSDictionary to see if we're fetching from URL
        apiURL = [reservationInfo objectForKey:@"apiURL"];
    }
    
    if ([apiURL length] > 1) {
        NSLog(@" ---- WE HAVE API URL: %@",apiURL);
        NSURL *apiCall = [NSURL URLWithString:apiURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:apiCall];
        
        data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
	//NSData* data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mobile-api-reservations-response" ofType:@"json"]];
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brief-test" ofType:@"json"]];
    }
	NSDictionary* payload = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //NSLog(@"DATA: %@",payload);
    NSArray *requests = [payload valueForKeyPath:@"requests"];
    NSDictionary *representation = nil;
    
    NSDictionary* individualJSON = [payload valueForKeyPath:@"individual"];
    NJOPIndividual *individual = [NJOPIndividual individualWithDictionaryRepresentation:individualJSON];
    
    NSString *userInfo = [NSString stringWithFormat:@"%@ - %@ - User ID: %@",individual.firstName, individual.lastName, individual.individualId];
    
    [NCLInfoPresenter presentText:userInfo];
    
    
    if ([requests count] > 0) {
        representation = [payload valueForKeyPath:@"requests"][0];
    } else {
        data = nil;
        payload = nil;
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brief-test" ofType:@"json"]];
        payload = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        representation = [payload valueForKeyPath:@"requests"][0];
    }
    


	NSString* jsonDateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
	NSDateFormatter* jsonDateFormatter = [NSDateFormatter new];
	[jsonDateFormatter setDateFormat:jsonDateFormat];

    // Need to return an NSArray of reservations
    NSArray *reservations;
	NJOPReservation* reservation = [NJOPReservation new];

    if (representation != nil) {
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
        reservation.rawData = jsonString;
    }

    // returning an array of reservations
    //reservations = [NSArray arrayWithObjects:reservation, nil];
    
	if (completionHandler) {
		completionHandler(reservation,nil);
	}
}

@end
