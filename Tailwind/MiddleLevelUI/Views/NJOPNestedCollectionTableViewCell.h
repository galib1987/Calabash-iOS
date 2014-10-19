//
//  NJOPNestedCollectionTableViewCell.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/13/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;
#import "SimpleDataSource.h"

@interface NJOPNestedCollectionTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UICollectionView* collectionView;
@property (nonatomic, strong) IBOutlet SimpleDataSource* dataSource;
@end
