//
//  NJWeatherTile.h
//  TailWind
//
//  Created by NetJets on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface NJWeatherTile : UIView
@property (nonatomic, weak) IBOutlet UILabel* leftDateLabel;
@property (nonatomic, weak) IBOutlet UILabel* leftLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel* leftTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel* leftTemperatureLabel;
@property (nonatomic, weak) IBOutlet UIImageView* leftImageView;

@property (nonatomic, weak) IBOutlet UILabel* rightDateLabel;
@property (nonatomic, weak) IBOutlet UILabel* rightLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel* rightTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel* rightTemperatureLabel;
@property (nonatomic, weak) IBOutlet UIImageView* rightImageView;

@end
