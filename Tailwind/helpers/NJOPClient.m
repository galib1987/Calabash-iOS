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
#import "NJOPSession.h"
#import "NJOPBrief.h"
#import "Defines.h"
//#import "NNNOAuthClient.h"

#import "NCLInfoPresenter.h"

#import "BFTask.h"

@interface NJOPClassDataTransformer : NJOPValueTransformer
@end

@implementation NJOPClient

+(void)GETContractsForAccount:(NSNumber *)accountId {
    //NNNOAuthClient *userSession = [NNNOAuthClient sharedInstance];
    //NSString *accessToken = userSession.credential.accessToken;
    
    NSData *data = nil;
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    /*
    if (USE_STATIC_DATA == 0) {
        NSString *urlString = [NSString stringWithFormat:@"https://%@%@?accountId=%@&appAgent=%@&access_token=%@", API_HOSTNAME, URL_CONTRACTS, accountId, API_SOURCE_IDENTIFIER, accessToken];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    } else {
     */
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"contracts" ofType:@"json"]];
    /*}*/
    
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@", dataDict);
    
}

+(void)GETWeatherForReservation:(NSNumber *)reservationId {
    //NNNOAuthClient *userSession = [NNNOAuthClient sharedInstance];
    //NSString *accessToken = userSession.credential.accessToken;
    
    NSData *data = nil;
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    /*
    if (USE_STATIC_DATA == 0) {
        NSString *urlString = [NSString stringWithFormat:@"https://%@%@?reservationId=%@&appAgent=%@&access_token=%@", API_HOSTNAME, URL_WEATHER, reservationId, API_SOURCE_IDENTIFIER, accessToken];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    } else {
     */
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weather-test" ofType:@"json"]];
    /*} */
    
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@", dataDict);
}

+(void)GETPastFlightsForAccounts:(NSArray *)accountIds {
    //NNNOAuthClient *userSession = [NNNOAuthClient sharedInstance];
    //NSString *accessToken = userSession.credential.accessToken;
    
    NSData *data = nil;
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    /*
    if (USE_STATIC_DATA == 0) {
        NSString *urlString = [NSString stringWithFormat:@"https://%@%@?accountIds=%@,&showAllFlights=true&searchFuture=false&appAgent=%@&access_token=%@", API_HOSTNAME, URL_FLIGHTS, @"1399122", API_SOURCE_IDENTIFIER, accessToken];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    } else {
     */
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"past-flights" ofType:@"json"]];
    /*}*/
    
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@", dataDict);
}


+(void)GETReservationsWithInfo:(NSDictionary *)reservationInfo completion:(void (^)(NSArray *reservations, NSError *error))completionHandler {
    NSString *apiURL = @"";
    NSData *data = nil;
    NSString *jsonString = @"";
    NSError *error = nil;
    NSURLResponse *response = nil;
    NJOPSession *session = [NJOPSession sharedInstance];
    NJOPBrief *brief = [[NJOPBrief alloc] init];
    
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
    
    NSLog(@"DATA: %@",payload);
    NSArray *requests = [payload valueForKeyPath:@"requests"];
    NSDictionary *representation = nil;
    
    NSDictionary* individualJSON = [payload valueForKeyPath:@"individual"];
    NJOPIndividual *individual = [NJOPIndividual individualWithDictionaryRepresentation:individualJSON];
    [session setIndividual:individual];
    
    NSArray *accountJSON = payload[@"individual"][@"accounts"];
    [session setAccounts:accountJSON];
    
//    
//    NSString *userInfo = [NSString stringWithFormat:@"%@ - %@ - User ID: %@",individual.firstName, individual.lastName, individual.individualId];
//    
//    [NCLInfoPresenter presentText:userInfo];
    
    
    if ([requests count] > 0) {
        representation = [payload valueForKeyPath:@"requests"][0];
    } else {
        data = nil;
        payload = nil;
    }
    
    
    
    NSString* jsonDateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    NSDateFormatter* jsonDateFormatter = [NSDateFormatter new];
    [jsonDateFormatter setDateFormat:jsonDateFormat];
    
    // Need to return an NSArray of reservations
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *representation in requests) {
        if (representation != nil) {
            
            NJOPReservation* reservation = [NJOPReservation new];
            
            reservation.reservationId = representation[@"reservationId"];
            reservation.aircraftType = representation[@"guaranteedAircraftTypeDescription"];
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
            reservation.passengers = representation[@"passengerManifest"][@"passengers"];
            reservation.cateringOrders = representation[@"cateringOrders"][0][@"cateringItems"];
            reservation.groundOrders = representation[@"groundOrders"];
            
            
            [results addObject:reservation];
        }
        
    }
    
    NSArray *reservations = [[NSArray alloc] initWithArray:results];
    [session setReservations:reservations];
    
    if (completionHandler) {
        completionHandler(reservations,nil);
    }
}

@end
