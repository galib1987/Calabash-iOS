//
//  NJOPFBOTile.h
//  Tailwind
//
//  Created by NetJets on 10/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

IB_DESIGNABLE

@interface NJOPFBOTile : UIView
@property (strong, nonatomic) IBInspectable UIImage* pinImage;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromAirportCodeLabel;
@property (strong, nonatomic) IBOutlet UIImageView* tailImageView;
@property (strong, nonatomic) IBOutlet UILabel* tailNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel* estimatedTimeLabel;
@end
