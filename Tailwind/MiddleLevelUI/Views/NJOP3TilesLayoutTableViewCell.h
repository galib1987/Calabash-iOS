//
//  NJOP3TilesLayoutTableViewCell.h
//  Tailwind
//
//  Created by NetJets on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//
#import "NJTileContainingTableViewCell.h"

@interface NJOP3TilesLayoutTableViewCell : NJTileContainingTableViewCell
@property (strong, nonatomic) IBOutlet UIView *leftTile;
@property (strong, nonatomic) IBOutlet UIView *rightTile;
@property (strong, nonatomic) IBOutlet UIView *middleTile;
@property (strong, nonatomic) IBOutlet UIView *bottomTile;

@end
