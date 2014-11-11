//
//  FBOTableCell.h
//  NetJets
//
//  Created by Amos Elmaliah on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface FBOTableCell : NJOPTableViewCell

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

@end
