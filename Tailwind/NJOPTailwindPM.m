//
//  NJOPTailwindPM.m
//  Tailwind
//
//  Created by Chad Long on 1/22/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPTailwindPM.h"
#import "NJOPReservation2.h"
#import "NJOPLeg.h"

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

- (NSString*)modelName
{
    return @"Tailwind";
}

- (NJOPAccount*)accountForID:(NSNumber*)accountID createIfNeeded:(BOOL)createIfNeeded moc:(NSManagedObjectContext*)moc
{
    NJOPAccount *account = [moc executeUniqueFetchRequestForEntityName:[NJOPAccount entityName] predicateKey:@"accountID" predicateValue:accountID error:nil];
    
    if (!account)
    {
        account = [NSEntityDescription insertNewObjectForEntityForName:[NJOPAccount entityName] inManagedObjectContext:moc];
        account.accountID = accountID;
    }
    
    return account;
}

- (NJOPReservation2*)reservationForID:(NSNumber*)reservationID createIfNeeded:(BOOL)createIfNeeded moc:(NSManagedObjectContext*)moc
{
    NJOPReservation2 *reservation = [moc executeUniqueFetchRequestForEntityName:[NJOPReservation2 entityName] predicateKey:@"reservationID" predicateValue:reservationID error:nil];
    
    if (!reservation)
    {
        reservation = [NSEntityDescription insertNewObjectForEntityForName:[NJOPReservation2 entityName] inManagedObjectContext:moc];
        reservation.reservationID = reservationID;
    }
    
    return reservation;
}

- (NJOPLeg*)legForID:(NSNumber*)legID createIfNeeded:(BOOL)createIfNeeded moc:(NSManagedObjectContext*)moc
{
    NJOPLeg *leg = [moc executeUniqueFetchRequestForEntityName:[NJOPLeg entityName] predicateKey:@"legID" predicateValue:legID error:nil];
    
    if (!leg)
    {
        leg = [NSEntityDescription insertNewObjectForEntityForName:[NJOPLeg entityName] inManagedObjectContext:moc];
        leg.legID = legID;
    }
    
    return leg;
}

- (NJOPLocation*)locationForID:(NSNumber*)fboID createIfNeeded:(BOOL)createIfNeeded moc:(NSManagedObjectContext*)moc
{
    NJOPLocation *location = [moc executeUniqueFetchRequestForEntityName:[NJOPLocation entityName] predicateKey:@"fboID" predicateValue:fboID error:nil];
    
    if (!location)
    {
        location = [NSEntityDescription insertNewObjectForEntityForName:[NJOPLocation entityName] inManagedObjectContext:moc];
        location.fboID = fboID;
    }
    
    return location;
}

- (NJOPAccount*)updateAccount:(NSDictionary*)accountDict moc:(NSManagedObjectContext*)moc
{
    NSNumber *accountID = [NSNumber numberFromObject:[accountDict objectForKey:@"accountId"]];
    NJOPAccount *account = [self accountForID:accountID createIfNeeded:YES moc:moc];
    
    account.accountName = [NSString stringFromObject:[accountDict objectForKey:@"accountName"]];
    account.osrTeamEmail = [NSString stringFromObject:[accountDict objectForKey:@"accountOSRTeamEmail"]];
    account.osrTeamName = [NSString stringFromObject:[accountDict objectForKey:@"accountOSRTeamName"]];
    account.osrTeamPhone = [NSString stringFromObject:[accountDict objectForKey:@"accountOSRTeamPhone"]];
    account.hasBookAuthorization = [NSNumber numberFromObject:[accountDict objectForKey:@"allowedToBookFlight"]];
    account.hasFlyAuthorization = [NSNumber numberFromObject:[accountDict objectForKey:@"allowedToFly"]];
    account.isPrincipal = [NSNumber numberFromObject:[accountDict objectForKey:@"isPrincipal"]];
    
    return account;
}

- (NJOPRequest2*)updateRequest:(NSDictionary*)requestDict moc:(NSManagedObjectContext*)moc
{
    // create/update reservation
    NSNumber *reservationID = [NSNumber numberFromObject:[requestDict objectForKey:@"reservationId"]];
    NJOPReservation2 *reservation = [self reservationForID:reservationID createIfNeeded:YES moc:moc];
    
    // create/update account
    NSNumber *accountID = [NSNumber numberFromObject:[requestDict objectForKey:@"accountId"]];
    NJOPAccount *account = [self accountForID:accountID createIfNeeded:YES moc:moc];
    account.accountName = [NSString stringFromObject:[requestDict objectForKey:@"accountName"]];
    reservation.account = account;
    
    // get a reference to the request (create it if it doesn't exist)
    NSNumber *requestID = [NSNumber numberFromObject:[requestDict objectForKey:@"requestId"]];
    __block NJOPRequest2 *request = nil;
    
    [reservation.requests enumerateObjectsUsingBlock:^(NJOPRequest2 *resRequest, BOOL *stop) {
        
        if ([resRequest.requestID isEqualToNumber:requestID])
        {
            request = resRequest;
            *stop = YES;
        }
    }];
    
    if (!request)
    {
        request = [NSEntityDescription insertNewObjectForEntityForName:[NJOPRequest2 entityName] inManagedObjectContext:moc];
        request.requestID = requestID;
        [reservation addRequestsObject:request];
    }
    
    // update the request
    request.status = [NSString stringFromObject:[requestDict objectForKey:@"requestStatusDescription"]];
    request.requestedAircraft = [NSString stringFromObject:[requestDict objectForKey:@"requestedAircraftTypeDescription"]];
    request.paxJSON = [requestDict objectForKey:@"passengerManifest"];
    
    // update the legs
    NSMutableSet *legSet = [NSMutableSet new];
    
    [request.legs enumerateObjectsUsingBlock:^(NJOPLeg *leg, BOOL *stop) {
        
        [legSet addObject:leg.legID];
    }];
    
    NSArray *legs = [requestDict objectForKey:@"legs"];
    
    [legs enumerateObjectsUsingBlock:^(NSDictionary *legDict, NSUInteger idx, BOOL *stop) {

        NSNumber *legID = [NSNumber numberFromObject:[legDict objectForKey:@"legId"]];
        NJOPLeg *leg = [self legForID:legID createIfNeeded:YES moc:moc];

        leg.request = request;
        leg.isFlown = [[NSNumber numberFromObject:[legDict objectForKey:@"flownStatus"]] isEqualToNumber:@3] ? @YES : @NO;
        leg.isInternational = [NSNumber numberFromObject:[legDict objectForKey:@"isInternational"]];
        leg.depTime = [NSDate dateFromISOString:[legDict objectForKey:@"etd"]];
        leg.arrTime = [NSDate dateFromISOString:[legDict objectForKey:@"eta"]];
        leg.actualAircraft = [NSString stringFromObject:[legDict objectForKey:@"actualAircraftType"]];
        leg.tailNumber = [NSString stringFromObject:[legDict objectForKey:@"tailNumber"]];
        
        NJOPLocation *depLocation = [self locationForID:[NSNumber numberFromObject:[legDict objectForKey:@"departureFBOId"]] createIfNeeded:YES moc:moc];
        depLocation.fboName = [NSString stringFromObject:[legDict objectForKey:@"departureFBOName"]];
        depLocation.airportID = [NSString stringFromObject:[legDict objectForKey:@"departureAirportId"]];
        depLocation.airportName = [NSString stringFromObject:[legDict objectForKey:@"departureAirportName"]];
        depLocation.timeZone = [NSString stringFromObject:[legDict objectForKey:@"departureTimeZoneId"]];
        leg.depLocation = depLocation;

        NJOPLocation *arrLocation = [self locationForID:[NSNumber numberFromObject:[legDict objectForKey:@"arrivalFBOId"]] createIfNeeded:YES moc:moc];
        arrLocation.fboName = [NSString stringFromObject:[legDict objectForKey:@"arrivalFBOName"]];
        arrLocation.airportID = [NSString stringFromObject:[legDict objectForKey:@"arrivalAirportId"]];
        arrLocation.airportName = [NSString stringFromObject:[legDict objectForKey:@"arrivalAirportName"]];
        arrLocation.timeZone = [NSString stringFromObject:[legDict objectForKey:@"arrivalTimeZoneId"]];
        leg.arrLocation = arrLocation;

        // set denormalized departure info on the request object
        if (idx == 0)
        {
            request.depTime = leg.depTime;
            request.depLocation = leg.depLocation;
        }
        
        // set denormalized arrival info on the request object
        if (idx == legs.count-1)
        {
            request.arrTime = leg.arrTime;
            request.arrLocation = leg.arrLocation;
        }
        
        [legSet removeObject:legID];
    }];
    
    // remove legs that have been deleted
    [legSet enumerateObjectsUsingBlock:^(NSNumber *legID, BOOL *stop) {
        
        [moc deleteAllObjectsForEntityName:[NJOPLeg entityName] predicate:[NSPredicate predicateWithFormat:@"legID == %@", legID] error:nil];
    }];
    
    return request;
}

@end
