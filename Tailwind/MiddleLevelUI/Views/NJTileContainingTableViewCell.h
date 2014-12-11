//
//  NJTileContainingTableViewCell.h
//  TailWind
//
//  Created by NetJets on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface NJTileContainingTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView* tile;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@end
