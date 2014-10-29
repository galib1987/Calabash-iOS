//
//  NJOPBriefTopCollectionViewCell.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPTileContainingCollectionViewCell.h"

@class NJSingleFBOTile, NJTailNumberTail, NJWeatherTile;
@interface NJOPBriefTopCollectionViewCell : NJOPTileContainingCollectionViewCell
@property (strong, nonatomic) IBOutlet NJSingleFBOTile *topLeftView;
@property (strong, nonatomic) IBOutlet NJTailNumberTail *topMiddleView;
@property (strong, nonatomic) IBOutlet NJSingleFBOTile *topRightView;
@property (strong, nonatomic) IBOutlet NJWeatherTile *bottomView;

@end
