//
//  NSDate+NJOP.m
//  Tailwind
//
//  Created by NetJets on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NSDate+NJOP.h"

static NSString* njop_spacialDate(NSDate* date,NSString* format, NSTimeZone* timezone) {
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:timezone ? : [NSTimeZone localTimeZone]];
	[dateFormatter setDoesRelativeDateFormatting:YES];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateFormat:format];
	return [dateFormatter stringFromDate:date];
}

@implementation NSDate (NJOP)

-(NSString *)njop_spacialDate:(NSString *)format timeZone:(NSTimeZone *)timezone {
	return njop_spacialDate(self, format, timezone);
}

@end

