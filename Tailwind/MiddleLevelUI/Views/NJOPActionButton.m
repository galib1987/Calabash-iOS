//
//  NJOPActionButton.m
//  Tailwind
//
//  Created by NetJets on 10/23/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPActionButton.h"

@interface NJOPActionButton ()
@end

@implementation NJOPActionButton

-(CGRect)titleRectForContentRect:(CGRect)contentRect {
	CGRect rect = [super titleRectForContentRect:contentRect];
	rect.origin.x -= [self currentImage].size.width;
	return rect;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect {
	CGRect rect = [super imageRectForContentRect:contentRect];
	rect.origin.x += self.titleLabel.bounds.size.width;
	return rect;
}

-(void)layoutSubviews {
	CGRect imageViewFrame = self.imageView.frame;
	imageViewFrame.origin.x = CGRectGetMaxX(self.titleLabel.frame);
	self.layer.borderColor = [UIColor blackColor].CGColor;
	self.layer.borderWidth = 1.0;
	[super layoutSubviews];
}

@end
