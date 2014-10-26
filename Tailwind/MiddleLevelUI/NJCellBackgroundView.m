//
//  NJCellBackgroundView.m
//  NetJets
//
//  Created by Amos Elmaliah on 10/5/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "NJCellBackgroundView.h"

@interface NJCellBackgroundView ()
@property (nonatomic) BOOL hasRadius;
@property (nonatomic, strong) UIView* innerView;
@end

@implementation NJCellBackgroundView

-(BOOL)isOpaque {
	return NO;
}

-(UIColor *)backgroundColor {
	return [UIColor clearColor];
}

-(void)setCornerRadius:(CGFloat)cornerRadius {
	if (_cornerRadius != cornerRadius) {
		_cornerRadius = cornerRadius;
		_hasRadius = _cornerRadius;
	}
}

-(void)setPadding:(CGSize)padding {
	if (!CGSizeEqualToSize(_padding, padding)) {
		_padding = padding;
		[self setNeedsLayout];
	}
}

-(UIView *)innerView {
	if (!_innerView) {
		_innerView = [[UIView alloc] initWithFrame:CGRectZero];
		_innerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
		[self addSubview:_innerView];
	}
	return _innerView;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	self.innerView.frame = CGRectInset(self.bounds, _padding.width, _padding.height);
	self.innerView.layer.cornerRadius = _hasRadius ? _cornerRadius : DEFAULT_CELL_CORENER_RADIUS;
}

@end
