//
//  NJOPNetJetsCorePM.m
//  Tailwind
//
//  Created by Chad Long on 1/22/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPAirportPM.h"

@implementation NJOPAirportPM

+ (NJOPAirportPM*)sharedInstance
{
    static dispatch_once_t pred;
    static NJOPAirportPM *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSString*)modelName
{
    return @"Airport";
}

- (BOOL)shouldAlwaysInstallResourcedDatabase
{
    return YES;
}

@end
