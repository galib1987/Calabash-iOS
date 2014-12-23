//
//  NJOPDrawRectWithCircleCutout.m
//  Tailwind
//
//  Created by Angus.Lo on 12/23/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPDrawRectWithCircleCutout.h"

@implementation NJOPDrawRectWithCircleCutout

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef cutoutRect = CGPathCreateMutable();
    CGPathAddRect(cutoutRect, NULL, rect);
    CGFloat diameter = rect.size.height;
    CGPathAddEllipseInRect(cutoutRect, NULL, CGRectMake((rect.size.width-diameter)/2, (rect.size.height-diameter)/2, diameter, diameter));
    
    CGContextAddPath(context, cutoutRect);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextEOFillPath(context);
}

@end
