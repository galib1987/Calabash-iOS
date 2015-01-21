//
//  NJOPAdvisoryNotesController.m
//  Tailwind
//
//  Created by netjets on 1/5/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPAdvisoryNotesController.h"
#import "NJOPAdvisoryNotesCell.h"

@interface NJOPAdvisoryNotesController ()

@end

@implementation NJOPAdvisoryNotesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataSource {
    
    NSArray *sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"TSA Screening Required",
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"List of Prohibited Items",
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"MedAire: Worldwide Medical and Travel Support",
                                          },
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"ADVISORY NOTES";
}

@end
