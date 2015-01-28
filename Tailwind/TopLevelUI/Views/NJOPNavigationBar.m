//
//  NJOPNavigationBar.m
//  Tailwind
//
//  Created by NetJets on 11/5/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPNavigationBar.h"

#define kAppNavBarHeight 50.0


@implementation NJOPNavigationBar

-(void)awakeFromNib {
	[self setBarTintColor:[UIColor navigationBarBackgroundColor]];
	[self setTintColor:[UIColor navigationBarBackgroundColor]];
	[self setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor navigationBarTextColor]}];
    
    UIImage *backBtn = [UIImage imageNamed:@"back arrow"];
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
