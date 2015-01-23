//
//  NJOPNetJetsCorePM.m
//  Tailwind
//
//  Created by Chad Long on 1/22/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPNetJetsCorePM.h"

@implementation NJOPNetJetsCorePM

+ (NJOPNetJetsCorePM*)sharedInstance
{
    static dispatch_once_t pred;
    static NJOPNetJetsCorePM *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSString*)modelName
{
    return @"NetJetsCore";
}

- (BOOL)shouldAlwaysInstallResourcedDatabase
{
    return YES;
}

@end
