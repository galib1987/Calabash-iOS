//
//  NJOPFlightDetailCell.h
//  Tailwind
//
//  Created by netjets on 12/31/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPFlightDetailCell : NJOPTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *guaranteedAircraftTypeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tailNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureFBONameLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureAirportIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureAirportCityLabel;

@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalAirportIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalAirportCityLabel;

@property (weak, nonatomic) IBOutlet UILabel *arrivalFBONameLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureWeatherDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureAirportCityAndStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureWeatherTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureTemperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *departureWeatherIcon;

@property (weak, nonatomic) IBOutlet UILabel *arrivalWeatherDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalAirportCityAndStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalWeatherTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTemperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrivalWeatherIcon;

@end
