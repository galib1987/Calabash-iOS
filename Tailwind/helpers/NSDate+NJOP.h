//
//  NSDate+NJOP.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+DateTools.h"

@interface NSDate (NJOP)
-(NSString*)njop_spacialDate:(NSString*)format timeZone:(NSTimeZone*) timezone;

@end
