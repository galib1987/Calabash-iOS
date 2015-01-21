//
//  NSDecimalNumber+Utility.m
//  NCLFramework
//
//  Created by Chad Long on 11/6/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import "NSDecimalNumber+Utility.h"

@implementation NSDecimalNumber (Utility)

+ (NSDecimalNumber*)decimalNumberFromObject:(id)object shouldUseZeroDefault:(BOOL)shouldUseZeroDefault scale:(NSUInteger)digitsToRightOfDecimal
{
    // check for nulls and invalid objects
    if (object == nil ||
        [object isEqual:[NSNull null]] ||
        (![object isKindOfClass:[NSNumber class]] && ![object isKindOfClass:[NSString class]]))
    {
        if (shouldUseZeroDefault)
            return [NSDecimalNumber zero];
        else
            return nil;
    }
    
    // get a decimal number
    NSDecimalNumber *decimalNumber = nil;
    
    if ([object isKindOfClass:[NSNumber class]])
    {
        decimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[object decimalValue]];
    }
    else
    {
        decimalNumber = [NSDecimalNumber decimalNumberWithString:object];
    }
    
    // check for nulls and invalid objects again
    if (!decimalNumber)
    {
        if (shouldUseZeroDefault)
            return [NSDecimalNumber zero];
        else
            return nil;
    }
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                             scale:digitsToRightOfDecimal
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:NO];
    
    return [decimalNumber decimalNumberByRoundingAccordingToBehavior:handler];
}

@end
