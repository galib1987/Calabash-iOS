//
//  FlightDetailTopHeaderView.m
//  NetJets
//
//  Created by Amos Elmaliah on 10/2/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "FlightDetailTopHeaderView.h"

@implementation FlightDetailTopHeaderView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = NAVIGATIONBAR_BACKGORUND_COLOR;
	}
	return self;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	self.backgroundColor = NAVIGATIONBAR_BACKGORUND_COLOR;
}

@end
