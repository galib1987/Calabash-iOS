//
//  NJOPFlightDetailCell.h
//  Tailwind
//
//  Created by netjets on 12/29/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPFlightDetailCell : NJOPTableViewCell

// Flight Details
@property (weak, nonatomic) IBOutlet UILabel *departureFboNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *guaranteedAircraftTypeLabel;

@property (nonatomic, weak) IBOutlet UILabel *departureLabel;

@property (nonatomic, weak) IBOutlet UILabel *fromFBOLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel *fromFBOAirpotCodeLabel;
@property (nonatomic, weak) IBOutlet UILabel *fromFBOTailNumberLabel;
@property (nonatomic, weak) IBOutlet UILabel *fromFBOTimeLabel;

@property (nonatomic, weak) IBOutlet UILabel *arrivalLabel;

@property (nonatomic, weak) IBOutlet UILabel *toFBOLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel *toFBOAirpotCodeLabel;
@property (nonatomic, weak) IBOutlet UILabel *toFBOTimeLabel;

@property (nonatomic, weak) IBOutlet UILabel *travelTimeLabel;

// Ground Transportation

// Forecasted Weather
@property (nonatomic, weak) IBOutlet UILabel* firstDateLabel;
@property (nonatomic, weak) IBOutlet UILabel* firstLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel* firstTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel* firstTemperatureLabel;
@property (nonatomic, weak) IBOutlet UIImageView* firstImageView;

@property (nonatomic, weak) IBOutlet UILabel* secondDateLabel;
@property (nonatomic, weak) IBOutlet UILabel* secondLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel* secondTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel* secondTemperatureLabel;
@property (nonatomic, weak) IBOutlet UIImageView* secondImageView;
@end
