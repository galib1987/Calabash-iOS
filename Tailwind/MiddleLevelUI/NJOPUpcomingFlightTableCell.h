//
//  NJOPUpcomingFlightTableCell.h
//  Tailwind
//
//  Created by NetJets on 11/11/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPUpcomingFlightTableCell : NJOPTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *destinationCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromFBODateLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromFBOTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromFBOAirportCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromFBOAiportNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *arrivalLabel;
@property (weak, nonatomic) IBOutlet UILabel *toFBOTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toFBOAirportCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toFBOAirportNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *travelTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *layoverLabel;


@end
