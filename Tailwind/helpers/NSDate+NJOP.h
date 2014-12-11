//
//  NSDate+NJOP.h
//  Tailwind
//
//  Created by NetJets on 10/28/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import Foundation;
#import "NSDate+DateTools.h"

@interface NSDate (NJOP)
-(NSString*)njop_spacialDate:(NSString*)format timeZone:(NSTimeZone*) timezone;

@end
