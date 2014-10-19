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
}

//-(void)layoutSubviews {
//	[super layoutSubviews];
//	self.label.text = [NSStringFromCGSize(self.frame.size) stringByAppendingString:NSStringFromCGSize([(UICollectionView*)self.superview contentSize])];
//}

-(void)setCornerRadius:(CGFloat)cornerRadius {
	if (_cornerRadius != cornerRadius) {
		_cornerRadius = cornerRadius;
		if (!self.backgroundView) {
			self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
			self.backgroundView.backgroundColor = [UIColor whiteColor];
		}
		self.backgroundView.layer.cornerRadius = _cornerRadius;
		if (_cornerRadius != 0) {
			[self.backgroundView setClipsToBounds:YES];
		}
		[self.contentView setNeedsDisplay];
	}
}

@end
