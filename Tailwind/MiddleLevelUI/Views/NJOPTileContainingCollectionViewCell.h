//
//  NJOPTileContainingCollectionViewCell.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface NJOPTileContainingCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIView* tile;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable UIColor* backgroundColor;
@end
