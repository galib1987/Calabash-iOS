//
//  FBOTableCell.m
//  NetJets
//
//  Created by NetJets on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "FBOTableCell.h"

@interface FBOTableCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintDateTimeMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTimeContractMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintContractTailMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintDepartureGroundMargin;

@property (weak, nonatomic) IBOutlet UIView *groupContent;
@property (weak, nonatomic) IBOutlet UIView *groupTailNumber;
@property (weak, nonatomic) IBOutlet UIView *groupGroundTransport;
@property (weak, nonatomic) IBOutlet UIView *groupDeparture;
@end

@implementation FBOTableCell

NSArray *allInfoConstraints;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFlightInfoAvailable:(int)flightInfoAvailable {
    _flightInfoAvailable = flightInfoAvailable;
    
    if (!(flightInfoAvailable & (tailNumber | groundTransport))) { // if neither available
        [self useNoTailNoGroundLayout];
    } else if (!(flightInfoAvailable & groundTransport)) {
        [self useNoGroundLayout];
    } else if (!(flightInfoAvailable & tailNumber)) {
        [self useNoTailLayout];
    }
}

- (void)useNoTailNoGroundLayout {
    
    self.constraintDateTimeMargin.constant = 50;
    self.constraintTimeContractMargin.constant = 50;
    self.constraintContractTailMargin.active = false;
    
    NSLayoutConstraint *contractDepartureMargin = [NSLayoutConstraint constraintWithItem:self.contractLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.groupDeparture attribute:NSLayoutAttributeTop multiplier:1 constant:-20];
    NSLayoutConstraint *departureContentMargin = [NSLayoutConstraint constraintWithItem:self.groupContent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.groupDeparture attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSArray *additionalConstraints = @[contractDepartureMargin, departureContentMargin];
    [NSLayoutConstraint activateConstraints:additionalConstraints];
    
    self.groupTailNumber.hidden = self.groupGroundTransport.hidden = true;
}

- (void)useNoGroundLayout {
    
    self.constraintDateTimeMargin.constant = 28;
    self.constraintTimeContractMargin.constant = 33;
    
    NSLayoutConstraint *departureContentMargin = [NSLayoutConstraint constraintWithItem:self.groupDeparture attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.groupContent attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSArray *additionalConstraints = @[departureContentMargin];
    [NSLayoutConstraint activateConstraints:additionalConstraints];
    
    self.groupGroundTransport.hidden = true;
}

- (void)useNoTailLayout {
    
    self.constraintDateTimeMargin.constant = 28;
    self.constraintTimeContractMargin.constant = 33;
    self.constraintDepartureGroundMargin.constant = 22;
    self.constraintContractTailMargin.active = false;
    
    NSLayoutConstraint *contractDepartureMargin = [NSLayoutConstraint constraintWithItem:self.contractLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.groupDeparture attribute:NSLayoutAttributeTop multiplier:1 constant:-27];
    
    NSArray *additionalConstraints = @[contractDepartureMargin];
    [NSLayoutConstraint activateConstraints:additionalConstraints];
    
    self.groupTailNumber.hidden = true;
}

@end
