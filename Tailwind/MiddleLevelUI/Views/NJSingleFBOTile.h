//
//  NJSingleFBOTile.h
//  TailWind
//
//  Created by NetJets on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

IB_DESIGNABLE

@interface NJSingleFBOTile : UIView
@property (strong, nonatomic) IBOutlet UIImageView* tailImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *directionLabel;
@property (strong, nonatomic) IBOutlet UILabel *airportNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *airportAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@end
