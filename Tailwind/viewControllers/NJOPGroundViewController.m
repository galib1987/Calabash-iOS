//
//  NJOPGroundViewController.m
//  Tailwind
//
//  Created by netjets on 1/6/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPGroundViewController.h"

@interface NJOPGroundViewController ()

@end

@implementation NJOPGroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataSource {
    
    NSDictionary *groundOrder = self.reservation.groundOrders[0];
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPGroundCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"groundTypeLabel.text" : groundOrder[@"groundType"],
                                                  @"autoSizeLabel.text" : groundOrder[@"autoSize"],
                                                  @"pickupTimeLabel.text" : @"11:00",
                                                  @"pickupDateLabel.text" : @"2:00",
                                                  @"routeDescLabel.text" : groundOrder[@"routeDescriptions"][0]
                                                  
                                                  }
                                          },
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"GROUND";
}


@end
