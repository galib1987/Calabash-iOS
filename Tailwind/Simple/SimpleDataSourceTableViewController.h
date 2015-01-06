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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@property (nonatomic, strong) IBOutlet SimpleDataSource* dataSource;
@end
