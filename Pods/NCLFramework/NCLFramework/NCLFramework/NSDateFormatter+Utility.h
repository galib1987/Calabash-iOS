//
//  NSDateFormatter+Utility.h
//  NCLFramework
//
//  Created by Chad Long on 9/9/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, NCLDateFormatOptions)
{
    NCLDateFormatOptionIncludeWeekday         = 1 << 0,
    NCLDateFormatOptionExcludeYear            = 1 << 1,
    NCLDateFormatOptionExcludeDay             = 1 << 2,
    NCLDateFormatOptionStripColons            = 1 << 3,
    NCLDateFormatOptionStripCommas            = 1 << 4,
    NCLDateFormatOptionTwoDigitDateComponents = 1 << 5,
    NCLDateFormatOptionUseShortMonth          = 1 << 6,
    NCLDateFormatOptionMilitaryTime           = 1 << 7,
};

typedef enum
{
    NCLDateFormatDateOnly = 1,
    NCLDateFormatTimeOnly,
    NCLDateFormatDateAndTime,
} NCLDateFormat;

@interface NSDateFormatter (Utility)

+ (NSDateFormatter*)dateFormatterFromFormatType:(NCLDateFormat)format;
+ (NSDateFormatter*)dateFormatterFromFormatType:(NCLDateFormat)format options:(NCLDateFormatOptions)options;
+ (NSDateFormatter*)dateFormatterFromFormatType:(NCLDateFormat)format options:(NCLDateFormatOptions)options timezone:(NSTimeZone*)timezone;

@end
