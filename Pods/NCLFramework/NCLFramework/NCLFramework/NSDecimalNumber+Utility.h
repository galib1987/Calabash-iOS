//
//  NSDecimalNumber+Utility.h
//  NCLFramework
//
//  Created by Chad Long on 11/6/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Utility)

+ (NSDecimalNumber*)decimalNumberFromObject:(id)object shouldUseZeroDefault:(BOOL)shouldUseZeroDefault scale:(NSUInteger)decimalPlaces;

@end
