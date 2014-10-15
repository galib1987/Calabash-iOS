//
//  SimpleDataSourceTableViewController.h
//  HTabDemo
//
//  Created by Amos Elmaliah on 10/12/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleDataSource.h"

@interface SimpleDataSourceTableViewController : UITableViewController
-(void)loadDataSource;
-(void)registerReusableViews;

@property (nonatomic, strong) IBOutlet SimpleDataSource* dataSource;
@end
