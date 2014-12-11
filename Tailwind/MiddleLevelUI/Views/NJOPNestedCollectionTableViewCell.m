//
//  NJOPNestedCollectionTableViewCell.m
//  Tailwind
//
//  Created by NetJets on 10/13/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPNestedCollectionTableViewCell.h"

@implementation NJOPNestedCollectionTableViewCell

- (void)awakeFromNib {
	if (self.collectionView && !self.collectionView.dataSource) {
		self.collectionView.dataSource = self.dataSource;
	}
}

@end
