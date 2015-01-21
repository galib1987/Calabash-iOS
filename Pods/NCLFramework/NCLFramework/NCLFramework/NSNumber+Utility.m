//
//  NSNumber+Utility.m
//  FliteDeck
//
//  Created by Chad Long on 5/25/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import "NSNumber+Utility.h"
#import "NSString+Utility.h"

@implementation NSNumber (Utility)

+ (NSNumber*)numberFromObject:(id)object
{
    return [NSNumber numberFromObject:object shouldUseZeroDefault:YES];
}

+ (NSNumber*)numberFromObject:(id)object shouldUseZeroDefault:(BOOL)shouldUseZeroDefault
{
    // check for nulls and invalid objects
    if (object == nil ||
        [object isEqual:[NSNull null]] ||
        (![object isKindOfClass:[NSNumber class]] && ![object isKindOfClass:[NSString class]]))
    {
        if (shouldUseZeroDefault)
            return [NSNumber numberWithInt:0];
        else
            return nil;
    }

    // establish a number object
    NSNumber *number = nil;
    
    if ([object isKindOfClass:[NSNumber class]])
        number = (NSNumber*)object;
    else
    {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setAllowsFloats:YES];
        
        // remove commas and currency symbols from strings
        NSMutableCharacterSet *charSet = [[NSMutableCharacterSet alloc] init];
        [charSet addCharactersInString:[f currencySymbol]];
        [charSet addCharactersInString:[f groupingSeparator]];
        
        number = [f numberFromString:[(NSString*)object stringByRemovingCharactersInCharacterSet:charSet]];
        
        if (number == nil)
        {
            if (shouldUseZeroDefault)
                return [NSNumber numberWithInt:0];
            else
                return nil;
        }
    }
    
    return number;
}

@end