//
//  NJOPCateringViewController.m
//  Tailwind
//
//  Created by netjets on 1/6/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPCateringViewController.h"
#import "NJOPCateringCell.h"
#import "NJOPMenuViewController.h"
#import "AppDelegate.h"

@interface NJOPCateringViewController ()

@end

@implementation NJOPCateringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataSource];
}

- (void)loadDataSource {
    NSMutableString *cateringString = [[NSMutableString alloc] init];
    
    for (NSDictionary *foodRepresentation in self.reservation.cateringOrders) {
        NSString *currentCateringItem = foodRepresentation[@"ownerFacingDescription"];
        [cateringString appendString:[NSString stringWithFormat:@"%@ \n", currentCateringItem]];
    }
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPCateringCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"foodItemsLabel.text" : cateringString,
                                                  
                                                  }
                                          },
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"CATERING";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)contactOSPressed:(id)sender {
    AppDelegate *delegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    [delegate.njopMenuViewController expandOS];
    
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
