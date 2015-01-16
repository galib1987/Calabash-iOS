//
//  NJOPPassengeManifestViewController.m
//  Tailwind
//
//  Created by netjets on 1/8/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPPassengeManifestViewController.h"

@interface NJOPPassengeManifestViewController ()

@end

@implementation NJOPPassengeManifestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableString *passengerManifestString = [[NSMutableString alloc] init];
    
    for (NSDictionary *passengerDict in self.reservation.passengers) {
        NSString *passengerName = [NSString stringWithFormat:@"%@ \n", passengerDict[@"passengerName"]];
        passengerManifestString = passengerName;
        
    }
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPPassengerManifestCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"manifestTextView.text" : passengerManifestString,
                                                  
                                                  }
                                          },
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"PASSENGER MANIFEST";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
