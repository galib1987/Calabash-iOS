//
//  NJOPiPadReservationDetailNavigationTitleView.m
//  Tailwind
//
//  Created by NetJets on 10/20/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPiPadReservationDetailNavigationTitleView.h"

@implementation NJOPiPadReservationDetailNavigationTitleView

-(CGSize)sizeThatFits:(CGSize)size {
	CGSize fittedSize = [super sizeThatFits:size];
	if (self.fittedSizeForSize) {
		return self.fittedSizeForSize(size,fittedSize);
	}
	return fittedSize;
}

@end
