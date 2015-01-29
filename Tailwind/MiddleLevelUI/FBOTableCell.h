//
//  FBOTableCell.h
//  NetJets
//
//  Created by NetJets on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

typedef enum {
    tailNumber = 1,
    groundTransport = 1 << 1
} FlightInfoAvailable;

@interface FBOTableCell : NJOPTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *flightDateLabel;

@property (nonatomic, weak) IBOutlet UILabel *departureLabel;

@property (nonatomic, weak) IBOutlet UILabel *fromFBODateLabel;
@property (nonatomic, weak) IBOutlet UILabel *fromFBOLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel *fromFBOAirpotCodeLabel;
@property (nonatomic, weak) IBOutlet UILabel *fromFBOTailNumberLabel;
@property (nonatomic, weak) IBOutlet UILabel *fromFBOTimeLabel;

@property (nonatomic, weak) IBOutlet UILabel *arrivalLabel;

@property (nonatomic, weak) IBOutlet UILabel *toFBODateLabel;
@property (nonatomic, weak) IBOutlet UILabel *toFBOLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel *toFBOAirpotCodeLabel;
@property (nonatomic, weak) IBOutlet UILabel *toFBOTimeLabel;

@property (nonatomic, weak) IBOutlet UILabel *travelTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *groundTransportLabel;

@property (weak, nonatomic) IBOutlet UILabel *contractLabel;

@property (weak, nonatomic) IBOutlet UIButton *viewFlightDetailsButton;

@property (nonatomic) int flightInfoAvailable;

- (void)useNoTailNoGroundLayout;

@end
