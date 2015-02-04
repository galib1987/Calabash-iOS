//
//  FBOTableCell.m
//  NetJets
//
//  Created by NetJets on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "FBOTableCell.h"

@interface FBOTableCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTopMargin;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allInfoDateTimeMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allInfoTimeContractMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allInfoContractDepartureMargin;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noTailNoGroundDateTimeMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noTailNoGroundTimeContractMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noTailNoGroundContractDepartureMargin;

@property (weak, nonatomic) IBOutlet UIView *groupFlightTime;
@property (weak, nonatomic) IBOutlet UIView *groupTailNumber;
@property (weak, nonatomic) IBOutlet UIView *groupGroundTransport;
@property (weak, nonatomic) IBOutlet UIView *groupDeparture;
@end

@implementation FBOTableCell

NSArray *allInfoConstraints;

- (void)awakeFromNib {
    // Initialization code
    allInfoConstraints = @[self.allInfoDateTimeMargin, self.allInfoTimeContractMargin, self.allInfoContractDepartureMargin];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFlightInfoAvailable:(int)flightInfoAvailable {
    _flightInfoAvailable = flightInfoAvailable;
    
    if (!(flightInfoAvailable & (tailNumber | groundTransport))) { // if neither available
        [self useNoTailNoGroundLayout];
    }
}

- (void)useNoTailNoGroundLayout {
    
    NSLayoutConstraint *dateTimeMargin = [NSLayoutConstraint constraintWithItem:self.flightDateLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.groupFlightTime attribute:NSLayoutAttributeTop multiplier:1 constant:-50];
    
    NSLayoutConstraint *timeContractMargin = [NSLayoutConstraint constraintWithItem:self.groupFlightTime attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contractLabel attribute:NSLayoutAttributeTop multiplier:1 constant:-50];
    
    NSLayoutConstraint *contractDepartureMargin = [NSLayoutConstraint constraintWithItem:self.contractLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.groupDeparture attribute:NSLayoutAttributeTop multiplier:1 constant:-20];
    
    
    NSArray *noTailNoGroundConstraints = @[dateTimeMargin, timeContractMargin, contractDepartureMargin];
    
    self.contentTopMargin.constant = 40;
    
    self.groupTailNumber.hidden = self.groupGroundTransport.hidden = true;
    
    [NSLayoutConstraint deactivateConstraints:allInfoConstraints];
    [NSLayoutConstraint activateConstraints:noTailNoGroundConstraints];
}

@end
