//
//  NJCellBackgroundView.m
//  NetJets
//
//  Created by Amos Elmaliah on 10/5/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "NJCellBackgroundView.h"

@interface NJCellBackgroundView ()
@property (nonatomic, strong) UIView* innerView;
@end

@implementation NJCellBackgroundView

-(BOOL)isOpaque {
	return NO;
}

-(UIColor *)backgroundColor {
	return [UIColor clearColor];
}

-(UIView *)innerView {
	if (!_innerView) {
		_innerView = [[UIView alloc] initWithFrame:CGRectZero];
		_innerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
		[self addSubview:_innerView];
	}
	return _innerView;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	self.innerView.frame = CGRectInset(self.bounds, 10, 2);
	self.innerView.layer.cornerRadius = DEFAULT_CELL_CORENER_RADIUS;
}

@end
