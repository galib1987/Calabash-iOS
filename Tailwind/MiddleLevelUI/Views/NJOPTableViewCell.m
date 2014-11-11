//
//  NJOPTableViewCell.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/23/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@implementation NJOPTableViewCell

-(void)commonInit {
	_tileCornerRadius = DEFAULT_CELL_CORENER_RADIUS;
	_tileColor = TABLEVIEW_CELL_TILE_COLOR;
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
	_tile.layer.cornerRadius  = _tileCornerRadius ? : DEFAULT_CELL_CORENER_RADIUS;
	_tile.backgroundColor = _tileColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
