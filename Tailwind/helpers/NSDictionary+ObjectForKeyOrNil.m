//
//  NSDictionary+ObjectForKeyOrNil.m
//  Tailwind
//
//  Created by netjets on 1/24/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NSDictionary+ObjectForKeyOrNil.h"

@implementation NSDictionary (ObjectForKeyOrNil)

- (id)objectForKeyOrNil:(id)key {
    id val = [self objectForKey:key];
    if ([val isEqual:[NSNull null]]) {
        return nil;
    }
    
    return val;
}

@end
