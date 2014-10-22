//
//  NJOPNavigationTitleView.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/20/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPNavigationTitleView.h"

@implementation NJOPNavigationTitleView


- (void)setFrame:(CGRect)frame {

	CGRect superviewBounds = self.superview.bounds;

	NSLog(@"frame:%@", NSStringFromCGRect(superviewBounds));
	if (!CGRectEqualToRect(superviewBounds, CGRectZero) ) {
		NSLog(@"%@", NSStringFromCGRect(self.superview.bounds));
		CGFloat left = frame.origin.x;;
		CGFloat right = CGRectGetMaxX(frame);

		for (UIView* subview in [self.superview subviews]) {
			if (subview != self) {
				CGFloat subviewRight = CGRectGetMaxX(subview.frame);
				CGFloat subviewLeft = CGRectGetMinX(subview.frame);
				if (subviewRight < left) {
					left = subviewRight;
				} else if(subviewLeft > right) {
					right = subviewLeft;
				}
				NSLog(@"%@", NSStringFromCGRect(subview.frame));
			}
		}

		CGRect adjustedFrame = CGRectMake(25, 0, self.superview.bounds.size.width, self.superview.bounds.size.height);
		frame = adjustedFrame;
	}
	[super setFrame:frame];
}

@end
