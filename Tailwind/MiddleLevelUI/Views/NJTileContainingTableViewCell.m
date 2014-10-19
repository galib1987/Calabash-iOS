//
//  NJTileContainingTableViewCell.m
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "NJTileContainingTableViewCell.h"

@implementation NJTileContainingTableViewCell

- (void)awakeFromNib {
	self.backgroundColor = [UIColor clearColor];
	self.cornerRadius = DEFAULT_CELL_CORENER_RADIUS;
}

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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

}

@end
