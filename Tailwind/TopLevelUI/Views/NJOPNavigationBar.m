//
//  NJOPNavigationBar.m
//  Tailwind
//
//  Created by Amos Elmaliah on 11/5/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPNavigationBar.h"

@implementation NJOPNavigationBar

-(void)awakeFromNib {
	[self setBarTintColor:NAVIGATIONBAR_BACKGORUND_COLOR];
	[self setTintColor:NAVIGATIONBAR_TINT_COLOR];
	[self setTitleTextAttributes:@{NSForegroundColorAttributeName : NAVIGATIONBAR_TEXT_COLOR}];
}

@end
