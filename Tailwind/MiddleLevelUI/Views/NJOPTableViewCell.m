//
//  NJOPTableViewCell.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/23/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@implementation NJOPTableViewCell


-(void)setTileColor:(UIColor *)tileColor {
	if (![_tileColor isEqual:tileColor]) {
		_tileColor = tileColor;
		[self.contentView setNeedsLayout];
	}
}

-(void)setTileCornerRadius:(CGFloat)tileCornerRadius {
	if (_tileCornerRadius != tileCornerRadius) {
		_tileCornerRadius = tileCornerRadius;
		[self.contentView setNeedsLayout];
	}
}

-(void)layoutSubviews {
	[super layoutSubviews];
//	self.tile.layer.borderColor = [UIColor blackColor].CGColor;
//	self.tile.layer.borderWidth = 1.0;
	_tile.layer.cornerRadius  = _tileCornerRadius ? : DEFAULT_CELL_CORENER_RADIUS;
	_tile.backgroundColor = _tileColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
