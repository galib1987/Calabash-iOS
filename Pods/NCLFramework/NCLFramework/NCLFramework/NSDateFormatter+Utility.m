//
//  NSDateFormatter+Utility.m
//  NCLFramework
//
//  Created by Chad Long on 9/9/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import "NSDateFormatter+Utility.h"
#import "NCLFramework.h"

@implementation NSDateFormatter (Utility)

+ (NSDateFormatter*)dateFormatterFromFormatType:(NCLDateFormat)format
{
    NSUInteger options = 0;
    
    if ([(NSNumber*)[NCLFramework appPreferenceForKey:NCLDateFormatShouldStripColonsKey] isEqualToNumber:@YES])
    {
        options = options | NCLDateFormatOptionStripColons;
    }
    
    if ([(NSNumber*)[NCLFramework appPreferenceForKey:NCLDateFormatShouldStripCommasKey] isEqualToNumber:@YES])
    {
        options = options | NCLDateFormatOptionStripCommas;
    }
    
    if ([(NSNumber*)[NCLFramework appPreferenceForKey:NCLDateFormatShouldUseTwoDigitDateComponentsKey] isEqualToNumber:@YES])
    {
        options = options | NCLDateFormatOptionTwoDigitDateComponents;
    }
    
    if ([(NSNumber*)[NCLFramework appPreferenceForKey:NCLDateFormatShouldUseMilitaryTimeKey] isEqualToNumber:@YES])
    {
        options = options | NCLDateFormatOptionMilitaryTime;
    }
    
    return [self dateFormatterFromFormatType:format options:options];
}

+ (NSDateFormatter*)dateFormatterFromFormatType:(NCLDateFormat)format options:(NCLDateFormatOptions)options
{
    return [self dateFormatterFromFormatType:format options:options timezone:[NSTimeZone defaultTimeZone]];
}

+ (NSDateFormatter*)dateFormatterFromFormatType:(NCLDateFormat)format options:(NCLDateFormatOptions)options timezone:(NSTimeZone*)timezone
{
    // get the standard format for the culture set on the device
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timezone];
    
    if (format != NCLDateFormatTimeOnly)
        [formatter setDateStyle:NSDateFormatterShortStyle];
    else
        [formatter setDateStyle:NSDateFormatterNoStyle];
    
    if (format != NCLDateFormatDateOnly)
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    else
        [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    // enforce two-digit month and day if preferred
    if (format != NCLDateFormatTimeOnly)
    {
        if (options & NCLDateFormatOptionIncludeWeekday)
        {
            formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:[formatter.dateFormat stringByAppendingString:@"EEE"]
                                                                   options:0
                                                                    locale:[NSLocale currentLocale]];
        }
        
        if (options & NCLDateFormatOptionExcludeYear)
        {
            formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:[formatter.dateFormat stringByReplacingOccurrencesOfString:@"y" withString:@""]
                                                                   options:0
                                                                    locale:[NSLocale currentLocale]];
        }
        
        if (options & NCLDateFormatOptionUseShortMonth &&
            [formatter.dateFormat rangeOfString:@"M" options:0].location != NSNotFound &&
            [formatter.dateFormat rangeOfString:@"MMM" options:0].location == NSNotFound)
        {
            NSUInteger index = [formatter.dateFormat rangeOfString:@"M" options:0].location;
            formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:@"M" withString:@""];
            formatter.dateFormat = [NSString stringWithFormat:@"%@%@%@", [formatter.dateFormat substringToIndex:index], @"MMM", [formatter.dateFormat substringFromIndex:index]];
            
            formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:formatter.dateFormat
                                                                   options:0
                                                                    locale:[NSLocale currentLocale]];
        }
        
        if (options & NCLDateFormatOptionExcludeDay)
        {
            formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:[formatter.dateFormat stringByReplacingOccurrencesOfString:@"d" withString:@""]
                                                                   options:0
                                                                    locale:[NSLocale currentLocale]];
        }
        
        if (options & NCLDateFormatOptionTwoDigitDateComponents)
        {
            if ([formatter.dateFormat rangeOfString:@"M" options:0].location != NSNotFound &&
                [formatter.dateFormat rangeOfString:@"MMM" options:0].location == NSNotFound &&
                [formatter.dateFormat rangeOfString:@"MM" options:0].location == NSNotFound)
            {
                formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:@"M" withString:@"MM"];
            }
            
            if ([formatter.dateFormat rangeOfString:@"d" options:0].location != NSNotFound &&
                [formatter.dateFormat rangeOfString:@"dd" options:0].location == NSNotFound)
            {
                formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:@"d" withString:@"dd"];
            }
            
            if ([formatter.dateFormat rangeOfString:@"yyyy" options:0].location != NSNotFound)
            {
                formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:@"yyyy" withString:@"yy"];
            }
        }
//        
//        INFOLog(@"date format: %@", formatter.dateFormat);
    }
    
    // enforce military time if preferred
    if (format != NCLDateFormatDateOnly)
    {
        if (options & NCLDateFormatOptionMilitaryTime)
        {
            if ([formatter.dateFormat rangeOfString:@"h" options:0].location != NSNotFound &&
                [formatter.dateFormat rangeOfString:@"hh" options:0].location == NSNotFound)
            {
                formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:@"h" withString:@"HH"];
            }
            
            else if ([formatter.dateFormat rangeOfString:@"hh" options:0].location != NSNotFound)
            {
                formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:@"hh" withString:@"HH"];
            }
            
            else if ([formatter.dateFormat rangeOfString:@"H" options:0].location != NSNotFound &&
                     [formatter.dateFormat rangeOfString:@"HH" options:0].location == NSNotFound)
            {
                formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:@"H" withString:@"HH"];
            }
            
            if ([formatter.dateFormat rangeOfString:@"a" options:0].location != NSNotFound)
            {
                formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:@"a" withString:@""];
                formatter.dateFormat = [formatter.dateFormat stringByTrimmingWhiteSpaceAndNewLines];
            }
        }
    }
    
    // strip colons if preferred
    static NSString *colon = @":";
    
    if ((options & NCLDateFormatOptionStripColons) &&
        [formatter.dateFormat rangeOfString:colon options:0].location != NSNotFound)
    {
        formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:colon withString:@""];
    }
    
    // strip commas if preferred
    static NSString *comma = @",";
    
    if ((options & NCLDateFormatOptionStripCommas) &&
        [formatter.dateFormat rangeOfString:comma options:0].location != NSNotFound)
    {
        formatter.dateFormat = [formatter.dateFormat stringByReplacingOccurrencesOfString:comma withString:@""];
    }
    
    return formatter;
}

@end
