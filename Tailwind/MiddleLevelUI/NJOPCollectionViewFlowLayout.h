//
//  NJOPCollectionViewFlowLayout.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@class NJOPCollectionViewFlowLayout;
@interface NJOPCollectionViewFlowLayoutAttribntes : UICollectionViewLayoutAttributes
@property (weak, nonatomic) NJOPCollectionViewFlowLayout* flowLayout;
@end

@interface NJOPCollectionViewFlowLayout : UICollectionViewFlowLayout
@end
