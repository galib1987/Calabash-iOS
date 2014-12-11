//
//  NJOPTileContainingCollectionViewCell.h
//  Tailwind
//
//  Created by NetJets on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface NJOPTileContainingCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIView* tile;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) UIColor* backgroundColor;
@end
