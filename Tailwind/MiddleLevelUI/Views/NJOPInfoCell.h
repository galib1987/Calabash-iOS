//
//  NJOPInfoCell.h
//  Tailwind
//
//  Created by NetJets on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTileContainingCollectionViewCell.h"

@interface NJOPInfoCell : NJOPTileContainingCollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *topLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end
