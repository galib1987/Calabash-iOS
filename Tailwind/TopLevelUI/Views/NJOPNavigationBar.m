//
//  NJOPNavigationBar.m
//  Tailwind
//
//  Created by NetJets on 11/5/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPNavigationBar.h"

#define kAppNavBarHeight 84.0


@implementation NJOPNavigationBar

-(void)awakeFromNib {
	[self setBarTintColor:NAVIGATIONBAR_BACKGORUND_COLOR];
	[self setTintColor:NAVIGATIONBAR_TINT_COLOR];
	[self setTitleTextAttributes:@{NSForegroundColorAttributeName : NAVIGATIONBAR_TEXT_COLOR}];
    
    UIImage *backBtn = [UIImage imageNamed:@"back arrow.png"];
    backBtn = [backBtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self setBackIndicatorImage:backBtn];
    [self setBackIndicatorTransitionMaskImage:backBtn];
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setTranslucent:YES];
    [self setShadowImage:[UIImage new]];
}

//- (CGSize)sizeThatFits:(CGSize)size {
//	CGFloat width = self.superview.frame.size.width;
//	return CGSizeMake(size.width, kAppNavBarHeight);
//
//}

@end
