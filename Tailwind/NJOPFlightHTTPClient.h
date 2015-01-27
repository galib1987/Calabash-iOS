//
//  NJOPHTTPClient.h
//  Tailwind
//
//  Created by Chad Long on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPFlightHTTPClient.h"

@interface NJOPFlightHTTPClient : NCLHTTPClient

+ (NJOPFlightHTTPClient*)sharedInstance;

- (void)loadBriefWithCompletion:(void (^)(NSArray *reservations, NSError *error))completionHandler;

- (void)loadFlightsWithAccountIds:(NSString *)accountIds
                       completion:(void (^)(NSArray *reservations, NSError *error))completionHandler;

- (void)loadContractsWithAccount:(NSString *)accountId
                      completion:(void (^)(NSArray *contracts, NSError *error))completionHandler;

- (void)loadWeatherWithReservation:(NSString *)reservationId
                        completion:(void (^)(NSArray *weatherReports, NSError *error))completionHandler;

- (void)loadAdvisoryWithReservation:(NSString *)reservationId
                         andRequest:(NSString *)requestId
                         completion:(void (^)(NSString *advisoryNotes, NSError *error))completionHandler;

@end
