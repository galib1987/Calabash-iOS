//
//  UIColor+NJOP.h
//  Tailwind
//
//  Created by Amos Elmaliah on 11/5/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface UIColor (NJOP)
+ (UIColor *)colorFromHexString:(NSString *)hexString;
@end

#define NAVIGATIONBAR_BACKGORUND_COLOR 			[UIColor colorFromHexString:@"#464D51"]
#define NAVIGATIONBAR_TINT_COLOR						[UIColor whiteColor]
#define NAVIGATIONBAR_TEXT_COLOR						[UIColor whiteColor]
#define HEADER_BACKGORUND_COLOR 						[UIColor colorFromHexString:@"#636D74"]
#define SCROLLVIEW_BACKGORUND_COLOR 				[UIColor colorFromHexString:@"#A1A8AE"]
#define VERTICAL_TABBAR_BACKGORUND_COLOR 		[UIColor colorFromHexString:@"#37393B"]
#define LIGHT_BACKGROUND_COLOR [UIColor colorFromHexString:@"#5B6165"]

