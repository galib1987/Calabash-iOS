//
//  NJOPHorizontalHairlineView.m
//  Tailwind
//
//  Created by NetJets on 11/6/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPHorizontalHairlineView.h"

@implementation NJOPHorizontalHairlineView

- (instancetype)init
{
	return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (!self)
		return nil;
	self.backgroundColor = HAIRLINE_COLOR;
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (!self)
		return nil;
	self.backgroundColor = HAIRLINE_COLOR;
	return self;
}

- (CGFloat)thickness
{
	return [[UIScreen mainScreen] scale] > 1 ? 0.5 : 1.0;
}

- (void)setFrame:(CGRect)frame
{
	CGFloat hairline = self.thickness;
	if (CGRectGetWidth(frame) > CGRectGetHeight(frame)) {
		frame.size.height = hairline;
		[self setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
		[self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	}
	else {
		frame.size.width = hairline;
		[self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
		[self setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
	}
	[super setFrame:frame];
}

- (CGSize)sizeThatFits:(CGSize)size
{
	size.height = self.thickness;
	return size;
}

- (CGSize)intrinsicContentSize
{
	return CGSizeMake(UIViewNoIntrinsicMetric, self.thickness);
}

@end
