//
//  NJOPTableViewCell.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/23/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

IB_DESIGNABLE

@interface NJOPTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *tile;
@property (nonatomic) IBInspectable CGFloat tileCornerRadius;
@property (nonatomic) IBInspectable UIColor* tileColor;
@end
