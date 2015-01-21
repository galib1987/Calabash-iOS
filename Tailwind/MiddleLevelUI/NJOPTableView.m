//
//  NJOPTableView.m
//  Tailwind
//
//  Created by NetJets on 11/5/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableView.h"
#import "UIColor+NJOP.h"

@implementation NJOPTableView

-(void)layoutSubviews {
	[super layoutSubviews];
//	self.backgroundColor = SCROLLVIEW_BACKGORUND_COLOR;
    [self setBackgroundView:[[UIImageView alloc] initWithImage:
                             [UIImage imageNamed:@"bkg-copy"]]];
}

@end
