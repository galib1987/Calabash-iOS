//
//  NJSingleFBOTile.m
//  TailWind
//
//  Created by NetJets on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJSingleFBOTile.h"
@interface NJSingleFBOTile ()
@property (nonatomic, strong) NSArray* constraints;
@end

@implementation NJSingleFBOTile

-(UILabel *)locationLabel {
	if (!_locationLabel) {
		_locationLabel = [UILabel new];
		[_locationLabel setFont:[UIFont preferredFontForTextStyle:@"Helvetica Neue Light 21.0"]];
		[self addSubview:_locationLabel];
	}
	return _locationLabel;
}

-(void)awakeFromNib {
	self.backgroundColor = [UIColor clearColor];
}

@end
