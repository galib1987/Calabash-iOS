//
//  NJOPTailwindPM.m
//  Tailwind
//
//  Created by Chad Long on 1/22/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPTailwindPM.h"
#import <NCLFramework/NCLPersistenceUtil.h>

@implementation NJOPTailwindPM

+ (NJOPTailwindPM*)sharedInstance
{
    static dispatch_once_t pred;
    static NJOPTailwindPM *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self mainMOC];
        _accounts = [NSArray new];
    }
    
    return self;
}

- (NSString*)modelName
{
    return @"Tailwind";
}

- (void)addReservationWithId:(NSNumber *)reservationId
{
    NJOPReservation2 *newReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation"
                                                                     inManagedObjectContext:self.mainMOC];
    newReservation.reservationID = reservationId;
    
    [self save];
}

- (void)addAccountWithId:(NSNumber *)accountId
{
    NJOPAccount *newAccount = [NSEntityDescription insertNewObjectForEntityForName:@"Account"
                                                            inManagedObjectContext:self.mainMOC];
    newAccount.accountID = accountId;
    
    [self save];
}

- (void)addRequestWithId:(NSNumber *)requestId
{
    NJOPRequest2 *newRequest = [NSEntityDescription insertNewObjectForEntityForName:@"Request"
                                                             inManagedObjectContext:self.mainMOC];
    newRequest.requestID = requestId;
    
    [self save];
}

- (void)fetchCoreData
{
    NSFetchRequest *fetchAccount = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
    
    self.accounts = [self.mainMOC executeFetchRequest:fetchAccount error:nil];
    
    [self save];
}

+ (BOOL)coreDataEmptyForEntityName:(NSString *)entityName inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSArray *fetchedItems = [context executeFetchRequest:request error:nil];
    
    if ([fetchedItems count] == 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
