//
//  NJOPTailwindPM.h
//  Tailwind
//
//  Created by Chad Long on 1/22/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NCLPersistenceManager.h"
#import "NJOPAccount.h"
#import "NJOPContract2.h"
#import "NJOPReservation2.h"
#import "NJOPRequest2.h"
#import "NJOPLocation.h"

@interface NJOPTailwindPM : NCLPersistenceManager

+ (NJOPTailwindPM*)sharedInstance;

- (NJOPAccount*)accountForID:(NSNumber*)accountID createIfNeeded:(BOOL)createIfNeeded moc:(NSManagedObjectContext*)moc;
- (NJOPContract2*)contractForID:(NSNumber*)contractID createIfNeeded:(BOOL)createIfNeeded moc:(NSManagedObjectContext*)moc;
- (NJOPReservation2*)reservationForID:(NSNumber*)reservationID createIfNeeded:(BOOL)createIfNeeded moc:(NSManagedObjectContext*)moc;
- (NJOPLeg*)legForID:(NSNumber*)legID createIfNeeded:(BOOL)createIfNeeded moc:(NSManagedObjectContext*)moc;
- (NJOPLocation*)locationForID:(NSNumber*)fboID createIfNeeded:(BOOL)createIfNeeded moc:(NSManagedObjectContext*)moc;

- (NJOPAccount*)updateAccount:(NSDictionary*)accountDict moc:(NSManagedObjectContext*)moc;
- (NJOPContract2*)updateContract:(NSDictionary*)contractDict moc:(NSManagedObjectContext*)moc;
- (NJOPRequest2*)updateRequest:(NSDictionary*)requestDict moc:(NSManagedObjectContext*)moc;

@end
