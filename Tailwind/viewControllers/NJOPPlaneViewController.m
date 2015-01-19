//
//  NJOPPlaneViewController.m
//  Tailwind
//
//  Created by netjets on 1/19/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPPlaneViewController.h"

@interface NJOPPlaneViewController ()

@end

@implementation NJOPPlaneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataSource {
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"PlaneBlurbCell"
                                          
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"PlaneInfoCell"
                                          
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"PlaneAmenitiesCell"
                                          
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"PlaneWifiCell"
                                          
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"PlaneCabinCell"
                                          
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"PlaneLayoutCell"
                                          
                                          }
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"YOUR PLANE";

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
