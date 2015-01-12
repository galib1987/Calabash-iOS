//
//  NJOPMessagesViewController.m
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPMessagesViewController.h"

@interface NJOPMessagesViewController ()

@end

@implementation NJOPMessagesViewController

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
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPMessageCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPMessageCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPMessageCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  }
                                          }
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = [@"Messages" uppercaseString];
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
