//
//  NJOPAirportResultTableViewCell.h
//  Tailwind
//
//  Created by Angus.Lo on 1/14/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPAirportResultTableViewCell : NJOPTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *airportNameLabel;

@end
