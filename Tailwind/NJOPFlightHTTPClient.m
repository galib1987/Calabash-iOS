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
            }
        }
    }];
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
            NSError *jsonError = nil;
            NSString *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            // parse & save to core data here
            
            if (completionHandler) {
                completionHandler(result,nil);
            }
            
        }
        
    }];
}


@end
