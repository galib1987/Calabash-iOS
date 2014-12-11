//
//  NJOPCollectionViewFlowLayout.h
//  Tailwind
//
//  Created by NetJets on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;
#import "NJOPCollectionParalaxViewInfo.h"

extern NSString *const NJOPCollectionPinnedParalaxHeaderIdentifier;

@class NJOPCollectionViewFlowLayout;
@interface NJOPCollectionViewFlowLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic) CGFloat progressiveness;
@end

@interface NJOPCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic) CGSize parallaxHeaderReferenceSize;
@property (nonatomic) CGSize parallaxHeaderMinimumReferenceSize;
@property (nonatomic) BOOL parallaxHeaderAlwaysOnTop;
@property (nonatomic) BOOL disablePinnedHeaders;
@end
