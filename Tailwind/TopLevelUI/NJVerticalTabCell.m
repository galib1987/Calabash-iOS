//
//  NJVerticalTabCell.m
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJVerticalTabCell.h"

@interface NJVerticalTabCell ()
@property (nonatomic, strong) NSArray* constraints;
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@end

@implementation NJVerticalTabCell

- (void)awakeFromNib {
	self.backgroundColor = [UIColor clearColor];
	self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
}

@end
