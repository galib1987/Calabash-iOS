//
//  NJOPTailwindPM.h
//  Tailwind
//
//  Created by Chad Long on 1/22/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NCLPersistenceManager.h"
#import "NJOPAccount.h"
#import "NJOPReservation2.h"
#import "NJOPRequest2.h"

@interface NJOPTailwindPM : NCLPersistenceManager

@property (strong, nonatomic) NSArray *accounts;
@property (strong, nonatomic) NSArray *reservations;
@property (strong, nonatomic) NSArray *requests;

+ (NJOPTailwindPM*)sharedInstance;
- (void)fetchCoreData;
- (void)addReservationWithId:(NSNumber *)reservationId;
- (void)addAccountWithId:(NSNumber *)accountId;
- (void)addRequestWithId:(NSNumber *)requestId;
+ (BOOL)coreDataEmptyForEntityName:(NSString *)entityName inContext:(NSManagedObjectContext *)context;

@end
