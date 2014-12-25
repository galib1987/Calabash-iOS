//
//  NJOPCurrentFBOTableCell.h
//  Tailwind
//
//  Created by NetJets on 11/11/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPCurrentFBOTableCell : NJOPTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *planeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tailNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromFBOTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromFBOAirportCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromFBOAirportNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *arrivalLabel;
@property (weak, nonatomic) IBOutlet UILabel *toFBOTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toFBOAirportCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toFBOAirportNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *travelTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *layoverLabel;

@end
