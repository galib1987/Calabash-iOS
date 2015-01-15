//
//  NJOPDatePickerDayCell.m
//  Tailwind
//
//  Created by Stephen.Cohrs on 1/14/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPDatePickerDayCell.h"

@implementation NJOPDatePickerDayCell


- (UIFont *)dayLabelFont
{
    return [UIFont fontWithName:@"NimbusSanD-Bol" size:16.0f];
}

- (UIColor *)dayLabelTextColor
{
    return [UIColor colorWithRed:51/255.0f green:37/255.0f blue:36/255.0f alpha:1.0f];
}

- (UIColor *)selectedDayImageColor
{
    return [UIColor clearColor];
}

- (UIFont *)selectedDayLabelFont
{
    return [self dayLabelFont];
}

- (UIColor *)selectedDayLabelTextColor
{
    return [self dayLabelTextColor];
}

- (UIColor *)dayOffLabelTextColor
{
    return [UIColor colorWithRed:51/255.0f green:37/255.0f blue:36/255.0f alpha:1.0f];
}

- (UIFont *)todayLabelFont
{
    return [UIFont fontWithName:@"NimbusSanD-Bol" size:16.0f];
}

- (UIColor *)todayLabelTextColor
{
    return [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
}

- (UIColor *)selectedTodayImageColor
{
    return [UIColor colorWithRed:0/255.0f green:121/255.0f blue:255/255.0f alpha:1.0f];
}

- (UIFont *)selectedTodayLabelFont
{
    return [self todayLabelFont];
}

- (UIColor *)selectedTodayLabelTextColor
{
    return [self todayLabelTextColor];
}

- (UIColor *)overlayImageColor
{
    return [UIColor colorWithWhite:1.0f alpha:1.0f];
}

- (UIColor *)dividerImageColor
{
    return [UIColor clearColor];
}

@end