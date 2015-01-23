//
//  NJOPTailwindPM.m
//  Tailwind
//
//  Created by Chad Long on 1/22/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPTailwindPM.h"

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

@end
