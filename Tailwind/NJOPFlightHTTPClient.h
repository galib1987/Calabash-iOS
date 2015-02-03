//
//  NJOPHTTPClient.h
//  Tailwind
//
//  Created by Chad Long on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPFlightHTTPClient.h"
#import "NJOPConfig.h"

extern NSString * const kAuthenticationSuccessNotification;
extern NSString * const kAuthenticationFailureNotification;
extern NSString * const kBriefLoadSuccessNotification;
extern NSString * const kBriefLoadFailureNotification;
extern NSString * const kWeatherSuccessNotification;
extern NSString * const kWeatherFailureNotification;
extern NSString * const kBookReservationSuccessNotification;
extern NSString * const kBookReservationFailureNotification;

@interface NJOPFlightHTTPClient : NCLHTTPClient

+ (NJOPFlightHTTPClient*)sharedInstance;

- (void)authenticate;
- (void)loadBrief;
- (void)loadWeatherForRequestID:(NSNumber*)requestID;
- (void)bookReservation:(NSDictionary*)reservationDict;

// ******************** HAVAS SECTION ********************

- (void)loadBriefInMemory;

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


#pragma mark - data helper methods

- (NSMutableArray *) loadReservationJSONArray:(NSArray *)JSONArray; // loads an NSArray of NSDictionaries and make into and NSArray of NJOPReservations
- (void) initializeUserData:(NSDictionary *)data; // loads data into the NJOPUser sharedInstance
@end
