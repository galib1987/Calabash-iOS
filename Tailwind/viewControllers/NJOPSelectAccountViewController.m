//
//  NJOPSelectAccountViewController.m
//  Tailwind
//
//  Created by netjets on 1/8/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPSelectAccountViewController.h"

@interface NJOPSelectAccountViewController ()

@end

@implementation NJOPSelectAccountViewController

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
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPAccountTableCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"accountNameLabel.text" : @"Company LLC",
                                                  @"principalNameLabel.text" : @"Douglas Richardson",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPAccountTableCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"accountNameLabel.text" : @"Other Company",
                                                  @"principalNameLabel.text" : @"Martin Crieff",
                                                  }
                                          }
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
