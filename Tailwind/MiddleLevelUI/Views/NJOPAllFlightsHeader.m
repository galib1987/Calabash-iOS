//
//  NJOPAllFlightsHeader.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/5/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPAllFlightsHeader.h"

@implementation NJOPAllFlightsHeader

-(UIView *)backgroundView {
	if (!_backgroundView) {
		_backgroundView = [UIView new];
		_backgroundView.backgroundColor = HEADER_BACKGORUND_COLOR;
		[self insertSubview:_backgroundView atIndex:0];
	}
	return _backgroundView;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	self.backgroundView.frame = self.bounds;
}

@end
