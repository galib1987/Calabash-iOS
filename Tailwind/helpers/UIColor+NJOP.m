//
//  UIColor+NJOP.m
//  Tailwind
//
//  Created by NetJets on 11/5/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "UIColor+NJOP.h"

@implementation UIColor (NJOP)

// Assumes input like "#00FF00" (#RRGGBB).
+ (UIColor *)colorFromHexString:(NSString *)hexString {
	NSAssert(hexString.length == 7, @"invalid hex color string");
	unsigned rgbValue = 0;
	NSScanner *scanner = [NSScanner scannerWithString:hexString];
	[scanner setScanLocation:1]; // bypass '#' character
	[scanner scanHexInt:&rgbValue];
	return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor *) navigationBarBackgroundColor {
    return [UIColor clearColor];
}

+ (UIColor *) navigationBarTextColor {
    return [UIColor whiteColor];
}

+ (UIColor *) scrollViewBackgroundColor {
    return [UIColor clearColor];
}

+ (UIColor *) mainNavButtonActiveColor {
    return [UIColor blackColor];
}

+ (UIColor *) mainNavButtonInActiveColor {
    return [UIColor whiteColor];
}




@end
