//
//  NJOPGroundViewController.m
//  Tailwind
//
//  Created by netjets on 1/6/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPGroundViewController.h"
#import <DateTools/NSDate+DateTools.h>

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
    
    NSDictionary *departureGroundOrder = _reservation.groundOrders[0];
    NSDictionary *arrivalGroundOrder = _reservation.groundOrders[1];
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPGroundCellDeparture",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"DEPARTURE",
                                                  @"groundTypeLabel.text" : departureGroundOrder[@"groundType"],
                                                  @"autoSizeLabel.text" : departureGroundOrder[@"autoSize"],
                                                  @"carServiceLabel.text" : departureGroundOrder[@"vendorName"],
                                                  @"pickupTimeLabel.text" : _reservation.departureTime,
                                                  @"pickupDateLabel.text" : _reservation.departureDateString,
                                                  @"routeDescLabel.text" : departureGroundOrder[@"routeDescriptions"][0],
                                                  @"passengers.text" : _reservation.passengers[0][@"passengerName"],
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPGroundCellArrival",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"ARRIVAL",
                                                  @"groundTypeLabel.text" : arrivalGroundOrder[@"groundType"],
                                                  @"autoSizeLabel.text" : arrivalGroundOrder[@"autoSize"],
                                                  @"carServiceLabel.text" : arrivalGroundOrder[@"vendorName"],
                                                  @"pickupTimeLabel.text" : _reservation.arrivalTime,
                                                  @"pickupDateLabel.text" : _reservation.arrivalDateString,
                                                  @"routeDescLabel.text" : arrivalGroundOrder[@"routeDescriptions"][0],
                                                  @"passengers.text" : _reservation.passengers[0][@"passengerName"],
                                                  }
                                          }
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"GROUND";
}


@end
