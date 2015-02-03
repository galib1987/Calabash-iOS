//
//  NJOPHTTPClient.m
//  Tailwind
//
//  Created by Chad Long on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPFlightHTTPClient.h"
#import "NJOPOAuthClient.h"
#import "NJOPIndividual.h"
#import "NJOPReservation.h"
#import "NJOPTailwindPM.h"
#import "NJOPRequest2.h"
#import "NJOPReservation2.h"
#import "NJOPAccount.h"

#import "NJOPValueTransformer.h"
#import "NSDate+NJOP.h"
#import "NSDateFormatter+Utility.h"
#import "Defines.h"
#import "NJOPUser.h"
#import "NJOPIntrospector.h"

NSString * const kBriefLoadSuccessNotification = @"BriefLoadSuccessNotification";
NSString * const kBriefLoadFailureNotification = @"BriefLoadFailureNotification";

@implementation NJOPFlightHTTPClient

#pragma mark - base implementation

+ (NJOPFlightHTTPClient*)sharedInstance
{
    static dispatch_once_t pred;
    static NJOPFlightHTTPClient *sharedInstance = nil;
    
    dispatch_once(&pred, ^{

        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSString*)host
{
    return API_HOSTNAME;
}

- (NSString*)basePath
{
    return API_BASEPATH;
}

- (NCLOAuthClient*)oAuthClient
{
    return [NJOPOAuthClient sharedInstance];
}

- (void)loadBrief
{
    NJOPConfig *conf = [NJOPConfig sharedInstance];
    if (conf.loadStaticJSON == YES) {
        // don't think we need to do anything here because this method goes nowhere
    } else {
        NCLURLRequest *request = [self urlRequestWithPath:@"/brief"];
        request.notificationNameOnSuccess = kBriefLoadSuccessNotification;
        request.notificationNameOnFailure = kBriefLoadFailureNotification;
        request.shouldUseSerialDispatchQueue = YES;
        //    request.shouldOutputTraceLog = YES;
        
        [self GET:request parameters:nil completionBlock:^(NSData *data, NSError *error) {
            
            if (!error)
            {
                NSManagedObjectContext *moc = [[NJOPTailwindPM sharedInstance] privateMOC];
                NSError *jsonError = nil;
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                
                if (!jsonError)
                {
                    NSDictionary *individualDict = [result objectForKey:@"individual"];
                    
                    if (individualDict)
                    {
                        // update user
                        [NJOPUser sharedInstance].individualID = [NSNumber numberFromObject:[individualDict objectForKey:@"individualId"]];
                        [NJOPUser sharedInstance].defaultAccountID = [NSNumber numberFromObject:[individualDict objectForKey:@"defaultAccountId"]];
                        [NJOPUser sharedInstance].firstName = [NSString stringFromObject:[individualDict objectForKey:@"firstName"]];
                        [NJOPUser sharedInstance].lastName = [NSString stringFromObject:[individualDict objectForKey:@"lastName"]];
                        [[NJOPUser sharedInstance] saveToDisk];
                        
                        // update accounts
                        NSArray *accounts = [[result objectForKey:@"individual"] objectForKey:@"accounts"];
                        
                        if (accounts)
                        {
                            [accounts enumerateObjectsUsingBlock:^(NSDictionary *accountDict, NSUInteger idx, BOOL *stop) {
                                
                                [[NJOPTailwindPM sharedInstance] updateAccount:accountDict moc:moc];
                            }];
                        }
                    }
                    
                    // update contracts
                    NSArray *contracts = [result objectForKey:@"contracts"];
                    
                    if (contracts)
                    {
                        [contracts enumerateObjectsUsingBlock:^(NSDictionary *contractDict, NSUInteger idx, BOOL *stop) {
                            
                            [[NJOPTailwindPM sharedInstance] updateContract:contractDict moc:moc];
                        }];
                    }
                    
                    // update requests
                    NSArray *requests = [result objectForKey:@"requests"];
                    
                    if (requests)
                    {
                        [requests enumerateObjectsUsingBlock:^(NSDictionary *requestDict, NSUInteger idx, BOOL *stop) {
                            
                            [[NJOPTailwindPM sharedInstance] updateRequest:requestDict moc:moc];
                        }];
                    }
                    
                    if (jsonError ||
                        ![moc save:nil])
                    {
                        NSLog(@"error saving brief");
                    }
                    
                    
                    // ********************* in-memory loading related ********************
                    
                    
                    // set individual for session
                    NSDictionary *individualJSON = [result valueForKeyPath:@"individual"];
                    NJOPIndividual *individual = [NJOPIndividual individualWithDictionaryRepresentation:individualJSON];
                    [individual setAccounts:individualJSON[@"accounts"]];
                    [[NJOPOAuthClient sharedInstance] setIndividual:individual];
                    
                    // set accounts for individual
                    NSArray *accountsJSON = [individualJSON valueForKeyPath:@"accounts"];
                    [[NJOPOAuthClient sharedInstance] setAccounts:accountsJSON];
                    
                    // set requests for account
                    NSMutableArray *reservationsArray = [NSMutableArray new];
                    NSString* jsonDateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
                    NSDateFormatter* jsonDateFormatter = [NSDateFormatter new];
                    [jsonDateFormatter setDateFormat:jsonDateFormat];
                    
                    NSArray *contractsJSON = [result valueForKeyPath:@"contracts"];
                    [[NJOPOAuthClient sharedInstance] setContracts:contractsJSON];
                    
                    
                    
                    NSArray *requestsJSON = [result valueForKeyPath:@"requests"];
                    if ([requestsJSON count] > 0) {
                        for (NSDictionary *requestDict in requestsJSON) {
                            if (requestDict != nil) {
                                NJOPReservation *reservation = [NJOPReservation new];
                                
                                reservation.reservationId = requestDict[@"reservationId"];
                                reservation.requestId = requestDict[@"requestId"];
                                reservation.aircraftType = requestDict[@"guaranteedAircraftTypeDescription"];
                                reservation.departureTimeZone = [NSTimeZone timeZoneWithAbbreviation:requestDict[@"departureTimeZoneFormat"]];
                                reservation.departureDate = [jsonDateFormatter dateFromString:requestDict[@"etdGmt"]];
                                reservation.departureTime = [reservation.departureDate formattedDateWithFormat:@"hh:mma zzz"
                                                                                                      timeZone:reservation.departureTimeZone];
                                
                                reservation.arrivalTimeZone = [NSTimeZone timeZoneWithAbbreviation:requestDict[@"arrivalTimeZoneFormat"]];
                                reservation.arrivalDate = [jsonDateFormatter dateFromString:requestDict[@"etaGmt"]];
                                reservation.arrivalTime = [reservation.arrivalDate formattedDateWithFormat:@"hh:mma zzz"
                                                                                                  timeZone:reservation.arrivalTimeZone];
                                
                                reservation.departureDateString = [reservation.departureDate njop_spacialDate:@"MMM DD yyyy"
                                                                                                     timeZone:reservation.departureTimeZone];
                                
                                reservation.arrivalDateString = [reservation.arrivalDate njop_spacialDate:@"MMM DD yyyy"
                                                                                                 timeZone:reservation.departureTimeZone];
                                
                                reservation.arrivalAirportId = requestDict[@"arrivalAirportId"];
                                reservation.departureAirportId = requestDict[@"departureAirportId"];
                                
                                reservation.tailNumber = requestDict[@"tailNumber"];
                                
                                reservation.departureFboName = requestDict[@"departureFboName"];
                                reservation.arrivalFboName = requestDict[@"arrivalFboName"];
                                
                                reservation.departureAirportCity = requestDict[@"departureAirportCity"];
                                reservation.arrivalAirportCity = requestDict[@"arrivalAirportCity"];
                                
                                reservation.estimatedTripTimeNumber = requestDict[@"estimatedTripTime"];
                                reservation.travelHours = @(reservation.estimatedTripTimeNumber.integerValue);
                                reservation.travelMinutes = @(ceilf((reservation.estimatedTripTimeNumber.floatValue - [reservation.travelHours floatValue])* 60));
                                
                                reservation.travelTime = [NSString stringWithFormat:@"%@h %@m",
                                                          reservation.travelHours,
                                                          reservation.travelMinutes];
                                
                                reservation.stops = @([requestDict[@"noOfFuelStops"] integerValue]);
                                reservation.stopsText = [reservation.stops boolValue] ? @"" : @"Non Stop";
                                reservation.passengers = requestDict[@"passengerManifest"][@"passengers"];
                                reservation.cateringOrders = requestDict[@"cateringOrders"][0][@"cateringItems"];
                                reservation.groundOrders = requestDict[@"groundOrders"];
                                reservation.departureFBOId = requestDict[@"departureFboId"];
                                
                                [reservationsArray addObject:reservation];
                            }
                        }
                    }
                }
            }
        }];
    } // end else load static JSON

}

- (void)loadFlightsForAccounts:(NSArray*)accountIDs
{
    NCLURLRequest *request = [self urlRequestWithPath:@"/flights"];
    NSDictionary *queryParams = @{@"accountIds":[accountIDs componentsJoinedByString:@","], @"showAllFlights":@"true"};
    request.notificationNameOnSuccess = @"flightsDidLoadNotification";
    request.notificationNameOnFailure = @"flightsDidNotLoadNotification";
    request.shouldPresentAlertOnError = YES;
//    request.shouldOutputTraceLog = YES;
    
    [self GET:request parameters:queryParams completionBlock:^(NSData *data, NSError *error) {
        
        if (error)
        {
            
        }
        else
        {
            NSManagedObjectContext *moc = [[NJOPTailwindPM sharedInstance] privateMOC];
            
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            NSArray *requests = [result objectForKey:@"requests"];
            
            if (!jsonError &&
                requests)
            {
                [requests enumerateObjectsUsingBlock:^(NSDictionary *requestDict, NSUInteger idx, BOOL *stop) {
                   
                    [[NJOPTailwindPM sharedInstance] updateRequest:requestDict moc:moc];
                }];
            }
            
            if (jsonError ||
                ![moc save:nil])
            {
                NSLog(@"error saving flights");
            }
        }
    }];
}

- (void)loadWeatherWithReservation:(NSString *)reservationId
                        completion:(void (^)(NSArray *weatherReports, NSError *))completionHandler {
    
    NCLURLRequest *request = [self urlRequestWithPath:@"/weather"];
    NSDictionary *queryParams = @{@"reserationId":reservationId, @"showAllFlights":@"true"};
    //    request.shouldOutputTraceLog = YES;
    
    [self GET:request parameters:queryParams completionBlock:^(NSData *data, NSError *error) {
        
        // ***** this block is executed on a background thread
        
        if (error)
        {
            
        }
        else
        {
            NSError *jsonError = nil;
            NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            NSLog(@"%@", result);
            if ([NJOPIntrospector isObjectArray:result]) {
                NSArray *weatherReports = result;
                completionHandler(weatherReports, nil);
            }
            // parse & save to core data here
            
        }
        
    }];
}


- (void)loadAdvisoryWithReservation:(NSString *)reservationId
                         andRequest:(NSString *)requestId
                         completion:(void (^)(NSString *advisoryNotes, NSError *))completionHandler {
    
    NCLURLRequest *request = [self urlRequestWithPath:@"/advisory"];
    NSDictionary *queryParams = @{@"reservationId":reservationId, @"requestId":requestId };
    //    request.shouldOutputTraceLog = YES;
    
    [self GET:request parameters:queryParams completionBlock:^(NSData *data, NSError *error) {
        
        // ***** this block is executed on a background thread
        
        if (error)
        {
            
        }
        else
        {

            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            // parse & save to core data here
            
            if (completionHandler) {
                completionHandler(result,nil);
            }
            
        }
        
    }];
}

- (void)loadBriefWithCompletion:(void (^)(NSArray *reservations, NSError *error))completionHandler
{
    NJOPConfig *conf = [NJOPConfig sharedInstance];
    if (conf.loadStaticJSON == YES) {
        NSMutableArray *reservationsArray = [NSMutableArray array];
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brief-test" ofType:@"json"]];
        if (data) {
            NSDictionary* payload = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *reservationJSON = [payload valueForKeyPath:@"requests"];
            reservationsArray = [self loadReservationJSONArray:reservationJSON];
            
            [[NJOPOAuthClient sharedInstance] setReservations:reservationsArray]; // this should be deprecated
            
            // set individual for session
            NSDictionary *individualJSON = [payload valueForKeyPath:@"individual"];
            NJOPIndividual *individual = [NJOPIndividual individualWithDictionaryRepresentation:individualJSON];
            [[NJOPOAuthClient sharedInstance] setIndividual:individual];
            
            // set accounts for individual
            NSArray *accountsJSON = [individualJSON valueForKeyPath:@"accounts"];
            [[NJOPOAuthClient sharedInstance] setAccounts:accountsJSON];
            
            NSArray *contractsJSON = [payload valueForKeyPath:@"contracts"];
            [[NJOPOAuthClient sharedInstance] setContracts:contractsJSON];

        }
        
        if (completionHandler) {
            NSLog(@"reservations - final: %@",reservationsArray);
            completionHandler(reservationsArray, nil);
        }
        

    } else {
        
        NCLURLRequest *request = [self urlRequestWithPath:@"/brief"];
        //    request.shouldOutputTraceLog = YES;
        
        [self GET:request parameters:nil completionBlock:^(NSData *data, NSError *error) {
            
            // ***** this block is executed on a background thread
            
            if (error)
            {
                
            }
            else
            {
                NSError *jsonError = nil;
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                
                // set individual for session
                NSDictionary *individualJSON = [result valueForKeyPath:@"individual"];
                NJOPIndividual *individual = [NJOPIndividual individualWithDictionaryRepresentation:individualJSON];
                [[NJOPOAuthClient sharedInstance] setIndividual:individual];
                
                // set accounts for individual
                NSArray *accountsJSON = [individualJSON valueForKeyPath:@"accounts"];
                [[NJOPOAuthClient sharedInstance] setAccounts:accountsJSON];
                
                // set requests for account
                NSMutableArray *reservationsArray = [NSMutableArray new];
                
                NSArray *contractsJSON = [result valueForKeyPath:@"contracts"];
                [[NJOPOAuthClient sharedInstance] setContracts:contractsJSON];

                NSArray *requestsJSON = [result valueForKeyPath:@"requests"];
                // make sure it's an array and that it actually has something in it
                if ([NJOPIntrospector isObjectArray:requestsJSON]) {
                    reservationsArray = [self loadReservationJSONArray:requestsJSON];
                } else {
                    reservationsArray = [NSMutableArray array]; // make sure we have an empty array
                }
                
                [[NJOPOAuthClient sharedInstance] setReservations:reservationsArray];
                
                if (completionHandler) {
                    completionHandler(reservationsArray, nil);
                }
                
            }
            
        }];
    } // end else static

}

- (NSMutableArray *) loadReservationJSONArray:(NSArray *)JSONArray {
    
    // set requests for account
    NSMutableArray *reservationsArray = [NSMutableArray new];
    
    NSString* jsonDateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    NSDateFormatter* jsonDateFormatter = [NSDateFormatter new];
    [jsonDateFormatter setDateFormat:jsonDateFormat];
    
    if ([NJOPIntrospector isObjectArray:JSONArray]) {
        for (NSDictionary *requestDict in JSONArray) {
            if ([NJOPIntrospector isObjectDictionary:requestDict]) {
                NJOPReservation *reservation = [NJOPReservation new];
                
                reservation.reservationId = requestDict[@"reservationId"];
                reservation.requestId = requestDict[@"requestId"];
                reservation.aircraftType = requestDict[@"guaranteedAircraftTypeDescription"];
                reservation.departureTimeZone = [NSTimeZone timeZoneWithAbbreviation:requestDict[@"departureTimeZoneFormat"]];
                reservation.departureDate = [jsonDateFormatter dateFromString:requestDict[@"etdGmt"]];
                reservation.departureTime = [reservation.departureDate formattedDateWithFormat:@"hh:mma zzz"
                                                                                      timeZone:reservation.departureTimeZone];
                
                reservation.arrivalTimeZone = [NSTimeZone timeZoneWithAbbreviation:requestDict[@"arrivalTimeZoneFormat"]];
                reservation.arrivalDate = [jsonDateFormatter dateFromString:requestDict[@"etaGmt"]];
                reservation.arrivalTime = [reservation.arrivalDate formattedDateWithFormat:@"hh:mma zzz"
                                                                                  timeZone:reservation.arrivalTimeZone];
                
                reservation.departureDateString = [reservation.departureDate njop_spacialDate:@"MMM DD yyyy"
                                                                                     timeZone:reservation.departureTimeZone];
                
                reservation.arrivalDateString = [reservation.arrivalDate njop_spacialDate:@"MMM DD yyyy"
                                                                                 timeZone:reservation.departureTimeZone];
                
                reservation.arrivalAirportId = requestDict[@"arrivalAirportId"];
                reservation.departureAirportId = requestDict[@"departureAirportId"];
                
                reservation.tailNumber = requestDict[@"tailNumber"];
                
                reservation.departureFboName = requestDict[@"departureFboName"];
                reservation.arrivalFboName = requestDict[@"arrivalFboName"];
                
                reservation.departureAirportCity = requestDict[@"departureAirportCity"];
                reservation.arrivalAirportCity = requestDict[@"arrivalAirportCity"];
                
                reservation.estimatedTripTimeNumber = requestDict[@"estimatedTripTime"];
                reservation.travelHours = @(reservation.estimatedTripTimeNumber.integerValue);
                reservation.travelMinutes = @(ceilf((reservation.estimatedTripTimeNumber.floatValue - [reservation.travelHours floatValue])* 60));
                
                reservation.travelTime = [NSString stringWithFormat:@"%@h %@m",
                                          reservation.travelHours,
                                          reservation.travelMinutes];
                
                reservation.stops = @([requestDict[@"noOfFuelStops"] integerValue]);
                reservation.stopsText = [reservation.stops boolValue] ? @"" : @"Non Stop";
                reservation.passengers = requestDict[@"passengerManifest"][@"passengers"];
                reservation.cateringOrders = requestDict[@"cateringOrders"][0][@"cateringItems"];
                reservation.groundOrders = requestDict[@"groundOrders"];
                [reservationsArray addObject:reservation];
            }
        } // end for each
    }
    return reservationsArray;
}

@end
