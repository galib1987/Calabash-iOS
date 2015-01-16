//
//  NJOPPastFlightTableCell.h
//  Tailwind
//
//  Created by Angus.Lo on 1/16/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJOPPastFlightTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursUsedLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLeftLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureAirportCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureLocationLabel;

@property (weak, nonatomic) IBOutlet UILabel *flightDurationLabel;

@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalAirportCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalLocationLabel;

@property (weak, nonatomic) IBOutlet UILabel *passengerNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *aircraftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *upgradedLabel;

@property (weak, nonatomic) IBOutlet UILabel *specialInstructionsLabel;

@end
