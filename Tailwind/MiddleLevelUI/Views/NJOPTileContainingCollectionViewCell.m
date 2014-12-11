//
//  NJOPTileContainingCollectionViewCell.m
//  Tailwind
//
//  Created by NetJets on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTileContainingCollectionViewCell.h"

@implementation NJOPTileContainingCollectionViewCell


-(void)commonInit {
	self.backgroundColor = [UIColor clearColor];
	self.cornerRadius = DEFAULT_CELL_CORENER_RADIUS;
	self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
	self.backgroundView.backgroundColor = [UIColor whiteColor];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	return self;
}

-(void)setCornerRadius:(CGFloat)cornerRadius {
	if (_cornerRadius != cornerRadius) {
		_cornerRadius = cornerRadius;
		self.layer.cornerRadius = _cornerRadius;
		[self setClipsToBounds:!!_cornerRadius];
	}
}

@end
