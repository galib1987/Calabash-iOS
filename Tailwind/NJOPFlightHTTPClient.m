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
#import "NJOPSession.h"
#import "NJOPTailwindPM.h"
#import "NJOPRequest2.h"
#import "NJOPReservation2.h"
#import "NJOPAccount.h"

#import "NJOPValueTransformer.h"
#import "NSDate+NJOP.h"
#import "NSDateFormatter+Utility.h"

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

- (void)loadBriefWithCompletion:(void (^)(NSArray *reservations, NSError *error))completionHandler
{
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
            
            // parse & save to core data here
            NSArray *requests = result[@"requests"];
            NSArray *accounts = result[@"individual"][@"accounts"];
            NSError *error = nil;
            
            NJOPTailwindPM *persistenceManager = [NJOPTailwindPM sharedInstance];
            NSManagedObjectContext *context = [persistenceManager mainMOC];
            
            for (NSDictionary *accountDict in accounts) {
                NJOPAccount *newAccount = [NSEntityDescription insertNewObjectForEntityForName:@"Account"
                                                                        inManagedObjectContext:context];
                newAccount.accountID = accountDict[@"accountId"];
                NSMutableSet *reservationsSet = [[NSMutableSet alloc] init];
                
                for (NSDictionary *requestDict in requests) {
                    if ([requestDict[@"accountId"] isEqualToNumber:newAccount.accountID]) {
                        NJOPReservation2 *newReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation"
                                                                                 inManagedObjectContext:context];
                        [reservationsSet addObject:newReservation];

                    }
                }
                
                [newAccount setReservations:reservationsSet];
            }
            
            NSLog(@"%@", [context registeredObjects]);
            
            
//            for (NSDictionary *accountDict in accounts) {
//                [persistenceManager addAccountWithId:accountDict[@"accountId"]];
//                NSLog(@"%@", [context registeredObjects]);
//            }
//            
//            for (NSDictionary *requestDict in requests) {
//                [persistenceManager addRequestWithId:requestDict[@"requestId"]];
//                [persistenceManager addReservationWithId:requestDict[@"reservationId"]];
//                NSLog(@"%@", [context registeredObjects]);
//            }
            
        }
        
    }];
}


- (void)loadFlightsWithAccountIds:(NSString *)accountIds
                       completion:(void (^)(NSArray *flights, NSError *))completionHandler {
    
    NCLURLRequest *request = [self urlRequestWithPath:@"/flights"];
    NSDictionary *queryParams = @{@"accountIds":accountIds, @"showAllFlights":@"true"};
    //    request.shouldOutputTraceLog = YES;
    
    [self GET:request parameters:queryParams completionBlock:^(NSData *data, NSError *error) {
        
        // ***** this block is executed on a background thread
        
        if (error)
        {
            
        }
        else
        {
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSArray *flights = result[@"requests"];
                completionHandler(flights, nil);
            }
            // parse & save to core data here
        }
        
    }];
}

- (void)loadContractsWithAccount:(NSString *)accountId
                      completion:(void (^)(NSArray *contracts, NSError *))completionHandler {
    
    NCLURLRequest *request = [self urlRequestWithPath:@"/contracts"];
    NSDictionary *queryParams = @{@"accountId":accountId};
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
            if ([result isKindOfClass:[NSArray class]]) {
                NSArray *contracts = result;
                completionHandler(contracts, nil);
            }
            // parse & save to core data here
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
            if ([result isKindOfClass:[NSArray class]]) {
                NSArray *weatherReports = result;
                completionHandler(weatherReports, nil);
            }
            // parse & save to core data here
            
        }
        
    }];
}

- (void)loadAdvisoryWithReservation:(NSString *)reservationId
                         andRequest:(NSString *)requestId
                         completion:(void (^)(NSArray *advisoryNotes, NSError *))completionHandler {
    
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
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            // parse & save to core data here
        }
        
    }];
}


@end
