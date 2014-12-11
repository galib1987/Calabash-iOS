//
//  NJOPTableViewCell.h
//  Tailwind
//
//  Created by NetJets on 10/23/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

IB_DESIGNABLE
// if the tile color and the tileCornerRadius do not show you may need to connect the tile IBOutlet in the nib to the view.
@interface NJOPTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *tile;
@property (nonatomic) CGFloat tileCornerRadius;
@property (nonatomic) UIColor* tileColor;
@end
