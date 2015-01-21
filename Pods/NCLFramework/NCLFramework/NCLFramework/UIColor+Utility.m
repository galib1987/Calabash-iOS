//
//  UIColor+Utility.m
//  NCLFramework
//
//  Created by Chad Long on 10/3/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

- (UIColor*)darkerColor
{
    return [self darkerColorWithOffset:0.2];
}

- (UIColor*)darkerColorWithOffset:(CGFloat)offset
{
    CGFloat r, g, b, a;
    
    if ([self getRed:&r green:&g blue:&b alpha:&a])
    {
        return [UIColor colorWithRed:MAX(r - (offset*3*0.299), 0.0)
                               green:MAX(g - (offset*3*0.587), 0.0)
                                blue:MAX(b - (offset*3*0.114), 0.0)
                               alpha:a];
    }

    CGFloat w, alpha;

    if ([self getWhite:&w alpha:&alpha])
    {
        return [UIColor colorWithWhite:MAX(w - offset, 0.0) alpha:alpha];
    }
    
    return self;
}

- (UIColor*)lighterColor
{
    return [self lighterColorWithOffset:0.2];
}

- (UIColor*)lighterColorWithOffset:(CGFloat)offset
{
    CGFloat r, g, b, a;
    
    if ([self getRed:&r green:&g blue:&b alpha:&a])
    {
        return [UIColor colorWithRed:MIN(r + (offset*3*0.299), 1.0)
                               green:MIN(g + (offset*3*0.587), 1.0)
                                blue:MIN(b + (offset*3*0.114), 1.0)
                               alpha:a];
    }
    
    CGFloat w, alpha;
    
    if ([self getWhite:&w alpha:&alpha])
    {
        return [UIColor colorWithWhite:MIN(w + offset, 1.0) alpha:alpha];
    }
    
    return self;
}

- (BOOL)isDark
{
    // get the greyscale
    UIColor *grayscale = [self grayscaleColor];
    
    // if white level is less than .5, the color is considered dark
    CGFloat alpha = 0;
    CGFloat white = 0;
    [grayscale getWhite:&white alpha:&alpha];
    
    if (white < 0.5f)
        return YES;
    else
        return NO;
}

- (UIColor*)grayscaleColor
{
    UIColor *grayscale = self;
    
    CGFloat red = 0;
    CGFloat blue = 0;
    CGFloat green = 0;
    CGFloat alpha = 0;
    
    if ([self getRed:&red green:&green blue:&blue alpha:&alpha])
    {
        grayscale = [UIColor colorWithWhite:(0.299*red + 0.587*green + 0.114*blue) alpha:alpha];
    }
    
    return grayscale;
}

- (UIColor*)colorWithHexString:(NSString*)hexString
{
    return [self colorWithHexString:hexString alpha:1];
}

- (UIColor*)colorWithHexString:(NSString*)hexString alpha:(CGFloat)alpha
{
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if (hexString.length == 6)
    {
        unsigned int hexValue;
        [[NSScanner scannerWithString:hexString] scanHexInt:&hexValue];
        
        return [UIColor colorWithRed:((float)((hexValue & 0xff0000) >> 16))/255.0
                               green:((float)((hexValue & 0xff00) >> 8))/255.0
                                blue:((float)(hexValue & 0xff))/255.0
                               alpha:alpha];
    }
    
    return nil;
}

- (UIImage*)backgroundImage
{
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    colorView.backgroundColor = self;
    
    UIGraphicsBeginImageContext(colorView.bounds.size);
    [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

@end