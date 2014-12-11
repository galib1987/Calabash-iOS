//
//  WeatherTableCell.h
//  NetJets
//
//  Created by NetJets on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface WeatherTableCell : NJOPTableViewCell
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
