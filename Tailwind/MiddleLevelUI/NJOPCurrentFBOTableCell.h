//
//  NJOPCurrentFBOTableCell.h
//  Tailwind
//
//  Created by NetJets on 11/11/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPCurrentFBOTableCell : NJOPTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *guaranteedAircraftTypeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tailNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureAirportIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalAirportIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureAirportCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalAirportCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimatedFlightTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimatedTripTimeLabel;

@end
