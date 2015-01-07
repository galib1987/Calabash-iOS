//
//  NJOPTripCompleteCell.h
//  Tailwind
//
//  Created by netjets on 1/3/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPTripCompleteCell : NJOPTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *completionGreetingLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *groundOrdersLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectedRemainingHoursLabel;

@property (weak, nonatomic) IBOutlet UIButton *viewFlightDetailsButton;

@end
