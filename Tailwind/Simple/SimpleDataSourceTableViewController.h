//
//  SimpleDataSourceTableViewController.h
//  Tailwind
//
//  Created by NetJets on 10/12/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;
#import "SimpleDataSource.h"

@interface SimpleDataSourceTableViewController : UITableViewController
-(void)loadDataSource;
-(void)registerReusableViews;

@property (nonatomic, strong) IBOutlet SimpleDataSource* dataSource;
@end
