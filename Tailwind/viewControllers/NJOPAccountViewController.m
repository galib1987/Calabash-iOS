//
//  NJOPAccountViewController.m
//  Tailwind
//
//  Created by netjets on 12/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPAccountViewController.h"

@interface NJOPAccountViewController ()

@end

@implementation NJOPAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource {
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPFlightTableCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"monthLabel.text" : @"JUN",
                                                  @"dateLabel.text" : @"31", // placeholder value
                                                  @"weekdayLabel.text" : @"Tuesday",
                                                  @"toFBOLocationLabel.text" : @"Yaoundé",
                                                  @"fromFBOLocationLabel.text" : @"Boca Raton",
                                                  @"timeDurationLabel.text" : @"12:00PM - 2:45AM",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPFlightTableCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"monthLabel.text" : @"JUN",
                                                  @"dateLabel.text" : @"31", // placeholder value
                                                  @"weekdayLabel.text" : @"Tuesday",
                                                  @"toFBOLocationLabel.text" : @"Sao Paolo",
                                                  @"fromFBOLocationLabel.text" : @"Vancouver",
                                                  @"timeDurationLabel.text" : @"12:00PM - 2:45AM",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPFlightTableCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"monthLabel.text" : @"JUN",
                                                  @"dateLabel.text" : @"31", // placeholder value
                                                  @"weekdayLabel.text" : @"Tuesday",
                                                  @"toFBOLocationLabel.text" : @"Seoul",
                                                  @"fromFBOLocationLabel.text" : @"Tokyo",
                                                  @"timeDurationLabel.text" : @"12:00PM - 2:45AM",
                                                  }
                                          },
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = [@"Book a Flight" uppercaseString];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
