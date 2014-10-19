//
//  NJWeatherTile.h
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

@import UIKit;

@interface NJWeatherTile : UIView
@property (nonatomic, weak) IBOutlet UILabel* dateLabel;
@property (nonatomic, weak) IBOutlet UILabel* firstLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel* firstTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel* firstTemperatureLabel;
@property (nonatomic, weak) IBOutlet UIImageView* firstImageView;
@end
