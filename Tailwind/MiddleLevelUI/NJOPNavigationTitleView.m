//
//  NJOPNavigationTitleView.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/20/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPNavigationTitleView.h"
#import "NJOPCollectionViewFlowLayout.h"

@implementation NJOPNavigationTitleView

-(CGSize)sizeThatFits:(CGSize)size {
	CGSize fittedSize = [super sizeThatFits:size];
	fittedSize.width = size.width;
	return fittedSize;
}

- (void)applyLayoutAttributes:(NJOPCollectionViewFlowLayoutAttributes *)layoutAttributes {

	[UIView beginAnimations:@"" context:nil];

	if (layoutAttributes.progressiveness >= 0.58) {
		self.leftTItle.alpha = 1;
		self.rightTitle.alpha = 1;

	} else {
		self.leftTItle.alpha = 0;
		self.rightTitle.alpha = 0;
	}

	[UIView commitAnimations];
}

@end
