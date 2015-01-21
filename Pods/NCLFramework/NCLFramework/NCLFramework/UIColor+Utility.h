//
//  UIColor+Utility.h
//  NCLFramework
//
//  Created by Chad Long on 10/3/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utility)

- (UIColor*)grayscaleColor;
- (UIColor*)darkerColor;
- (UIColor*)darkerColorWithOffset:(CGFloat)offset;
- (UIColor*)lighterColor;
- (UIColor*)lighterColorWithOffset:(CGFloat)offset;
- (BOOL)isDark;

- (UIColor*)colorWithHexString:(NSString*)hexString;
- (UIColor*)colorWithHexString:(NSString*)hexString alpha:(CGFloat)alpha;

- (UIImage*)backgroundImage;

@end
