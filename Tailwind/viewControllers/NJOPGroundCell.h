//
//  NJOPGroundCell.h
//  Tailwind
//
//  Created by netjets on 1/6/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPGroundCell : NJOPTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *groundTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *autoSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pickupTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pickupDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *routeDescLabel;
@property (weak, nonatomic) IBOutlet UITextView *passengers;
@property (weak, nonatomic) IBOutlet UILabel *carServiceLabel;

@end
