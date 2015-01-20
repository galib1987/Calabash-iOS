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
    
    [self loadDataSource];
    
}

- (void)loadDataSource {
    NSMutableString *manifestString = [[NSMutableString alloc] init];
    
    for (NSDictionary *passengerRepresentation in self.reservation.passengers) {
        NSString *currentPassengerName = passengerRepresentation[@"passengerName"];
        [manifestString appendString:[NSString stringWithFormat:@"%@ \n", currentPassengerName]];
    }
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPPassengerManifestCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"manifestTextView.text" : manifestString,
                                                  
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


@end
