//
//  NJOPTileContainingCollectionViewCell.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTileContainingCollectionViewCell.h"

@implementation NJOPTileContainingCollectionViewCell

- (void)awakeFromNib {
	self.backgroundColor = [UIColor clearColor];
	self.cornerRadius = DEFAULT_CELL_CORENER_RADIUS;
	self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
	self.backgroundView.backgroundColor = [UIColor whiteColor];
}

-(void)setCornerRadius:(CGFloat)cornerRadius {
	if (_cornerRadius != cornerRadius) {
		_cornerRadius = cornerRadius;
		self.layer.cornerRadius = _cornerRadius;
		[self setClipsToBounds:!!_cornerRadius];
	}
}

@end
