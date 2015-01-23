//
//  NJOPIntrospector.m
//  Tailwind
//
//  Created by netjets on 1/23/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPIntrospector.h"

@implementation NJOPIntrospector

+ (BOOL)isObjectArray:(id)object {
    if ([object isKindOfClass:[NSArray class]] && ([(NSArray *)object count] >= 1)) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isObjectDictionary:(id)object {
    if ([object isKindOfClass:[NSDictionary class]]) {
        return YES;
    } else {
        return NO;
    }
}
@end
