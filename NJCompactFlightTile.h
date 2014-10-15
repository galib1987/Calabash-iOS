//
//  NJCompactFlightTile.h
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJCompactFlightTile : UIView
@property (strong, nonatomic) IBOutlet UILabel *headingLabel;
@property (strong, nonatomic) IBOutlet UILabel *topLeftLabel;
@property (strong, nonatomic) IBOutlet UILabel *topRightLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomRightLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomLeftLabel;
@end
