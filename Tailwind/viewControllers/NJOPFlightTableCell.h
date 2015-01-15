//
//  NJOPFlightTableCell.h
//  Tailwind
//
//  Created by netjets on 12/29/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPFlightTableCell : NJOPTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;


@property (weak, nonatomic) IBOutlet UILabel *toFBOLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromFBOLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDurationLabel;

@end
