//
//  NJOPCrewViewController.m
//  Tailwind
//
//  Created by netjets on 1/6/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPCrewViewController.h"

@interface NJOPCrewViewController ()

@end

@implementation NJOPCrewViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataSource];
}

- (void)loadDataSource {
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPCrewCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"CAPTAIN",
                                                  @"crewMemberLabel.text" : @"Michael Chapman",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPCrewCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"PILOT",
                                                  @"crewMemberLabel.text" : @"Mike Anderson",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPCrewCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"FLIGHT ATTENDANT",
                                                  @"crewMemberLabel.text" : @"Kate Davenport, Mel Chakwin",
                                                  }
                                          }
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"YOUR CREW";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
