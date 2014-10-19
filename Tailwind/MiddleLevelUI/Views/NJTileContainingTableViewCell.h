//
//  NJTileContainingTableViewCell.h
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

@import UIKit;

@interface NJTileContainingTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView* tile;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@end
