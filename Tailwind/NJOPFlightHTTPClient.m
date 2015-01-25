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
#import "NJOPReservation2.h"
#import "NJOPAccount.h"
#import "NJOPRequest2.h"

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

//- (void)parseJSONObjects:(id)objects {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSInteger totalRecords = [objects count];
//        NSInteger currentRecord = 0;
//        
//        NSManagedObjectContext *context = [[NJOPTailwindPM sharedInstance] mainMOC];
//        
//        for (NSDictionary *dictionary in objects) {
//            NSInteger reservationId = [[dictionary objectForKey:@"reservationId"] intValue];
//            NJOPReservation2 *reservation = [NJOPReservation2 reservationWithReservationId:reservationId usingManagedObjectContext:context];
//            
//            if (reservation == nil) {
//                reservation = [NJOPReservation2 insertInManagedObjectContext:context];
//            }
//            
//            [reservation updateAttributes:dictionary];
//            
//            currentRecord++;
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                float percent = ((float) currentRecord)/totalRecords;
//                NSLog(@"%f loaded...", percent);
//            });
//        }
//        
//        NSError *error = nil;
//        if([context save:&error]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"DONE!");
//            });
//            
//        } else {
//            NSLog(@"ERROR: %@ %@", [error localizedDescription], [error userInfo]);
//            exit(1);
//        }
//        
//    });
//
//    
//}

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
            NSArray *reservations = result[@"requests"];
            NSArray *accounts = result[@"individual"][@"accounts"];
            // parse & save to core data here
            NSManagedObjectContext *moc = [[NJOPTailwindPM sharedInstance] mainMOC];
            NSError *error = nil;
            
            for (NSDictionary *accountDict in accounts) {
                NJOPAccount *newAccount = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:moc];
                newAccount.accountID = accountDict[@"accountId"];
            }
            
            for (NSDictionary *reservationDict in reservations) {
                NJOPReservation2 *newReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:moc];
                newReservation.reservationID = reservationDict[@"reservationId"];
                
                NJOPRequest2 *newRequest = [NSEntityDescription insertNewObjectForEntityForName:@"Request" inManagedObjectContext:moc];
                newRequest.requestID = reservationDict[@"requestId"];
            }
            
            NSLog(@"%@", [moc registeredObjects]);
            
            [moc save:&error];
            
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
