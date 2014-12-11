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
}

//- (CGSize)sizeThatFits:(CGSize)size {
//	CGFloat width = self.superview.frame.size.width;
//	return CGSizeMake(size.width, kAppNavBarHeight);
//
//}

@end
