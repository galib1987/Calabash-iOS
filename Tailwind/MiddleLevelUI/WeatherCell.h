//
//  WeatherCell.h
//  NetJets
//
//  Created by Amos Elmaliah on 9/30/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface WeatherCell : NJOPTableViewCell
@property (nonatomic, weak) IBOutlet UILabel* dateLabel;
@property (nonatomic, weak) IBOutlet UILabel* firstLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel* firstTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel* firstTemperatureLabel;
@property (nonatomic, weak) IBOutlet UIImageView* firstImageView;

@property (nonatomic, weak) IBOutlet UILabel* secondLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel* secondTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel* secondTemperatureLabel;
@property (nonatomic, weak) IBOutlet UIImageView* secondImageView;
@end
