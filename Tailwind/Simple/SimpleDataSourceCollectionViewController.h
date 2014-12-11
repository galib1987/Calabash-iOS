//
//  SimpleDataSourceCollectionViewController.h
//  TailWind
//
//  Created by NetJets on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;
#import "SimpleDataSource.h"

@interface SimpleDataSourceCollectionViewController : UICollectionViewController
@property (nonatomic, strong) IBOutlet SimpleDataSource* dataSource;
-(void)loadDataSource;
-(void)registerReusableViews;
@end
