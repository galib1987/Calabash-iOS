//
//  UIColor+NJOP.h
//  Tailwind
//
//  Created by NetJets on 11/5/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface UIColor (NJOP)

+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (UIColor *) navigationBarBackgroundColor;
+ (UIColor *) navigationBarTextColor;
+ (UIColor *) scrollViewBackgroundColor;
+ (UIColor *) mainNavButtonActiveColor;
+ (UIColor *) mainNavButtonInActiveColor;

@end

#define TOOLBAR_BACKGROUND_COLOR						[UIColor colorFromHexString:@/*"#2E2E2E"*/"#121212"]
#define NAVIGATIONBAR_BACKGORUND_COLOR 			[UIColor colorFromHexString:@"#464D51"]
#define NAVIGATIONBAR_TINT_COLOR						[UIColor whiteColor]
#define NAVIGATIONBAR_TEXT_COLOR						[UIColor whiteColor]
#define HEADER_BACKGORUND_COLOR 						[UIColor colorFromHexString:@"#636D74"]
#define SCROLLVIEW_BACKGORUND_COLOR 				[UIColor colorFromHexString:@"#A1A8AE"]
#define VERTICAL_TABBAR_BACKGORUND_COLOR 		[UIColor colorFromHexString:@"#37393B"]
#define HAIRLINE_COLOR 											[UIColor colorWithWhite:204.0/255.0 alpha:1]
#define LIGHT_BACKGROUND_COLOR 							[UIColor colorFromHexString:@"#5B6165"]
#define TABLEVIEW_CELL_TILE_COLOR						[UIColor whiteColor]
