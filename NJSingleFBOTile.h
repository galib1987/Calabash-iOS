//
//  NJSingleFBOTile.h
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJSingleFBOTile : UIView
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *directionLabel;
@property (strong, nonatomic) IBOutlet UILabel *airportNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *airportAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@end
