//
//  SimpleDataSourceCollectionViewController.h
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleDataSource.h"

@interface SimpleDataSourceCollectionViewController : UICollectionViewController
@property (nonatomic, strong) IBOutlet SimpleDataSource* dataSource;
-(void)loadDataSource;
-(void)registerReusableViews;
@end
