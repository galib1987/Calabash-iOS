//
//  NJOPPastFlightTableCell.m
//  Tailwind
//
//  Created by Angus.Lo on 1/16/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPPastFlightTableCell.h"

@implementation NJOPPastFlightTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setActionButtonLabel:(NSString *)actionButtonLabel {
    _actionButtonLabel = actionButtonLabel;
    
    [self.actionButton setTitle:self.actionButtonLabel forState:UIControlStateNormal];
}

@end
