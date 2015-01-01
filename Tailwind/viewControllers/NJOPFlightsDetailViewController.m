//
//  NJOPFlightsDetailViewController.m
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPFlightsDetailViewController.h"
#import "NJOPClient+flights.h"

@interface NJOPFlightsDetailViewController ()

@end

@implementation NJOPFlightsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource {
    
    __weak NJOPFlightsDetailViewController* wself = self;
    
    [NJOPClient GETReservationWithInfo:nil completion:^(NJOPReservation *reservation, NSError *error) {
        [wself updateWithReservation:reservation];
    }];
}

-(void)updateWithReservation:(NJOPReservation*)reservation {
    NSLog(@"%@", reservation);
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey		: @"NJOPFlightDetailCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Your Plane",
                                                  @"detailLabel.text" : @"Cessna Citation Encore+",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Ground Transportation",
                                                  @"detailLabel.text" : @"Requested",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Your Crew",
                                                  @"detailLabel.text" : @"Captain Brad Hanshaw",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Passenger Manifest",
                                                  @"detailLabel.text" : @"2 Passengers",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Catering",
                                                  @"detailLabel.text" : @"Requested",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Advisory Notes",
                                                  @"detailLabel.text" : @"Please Read",
                                                  }
                                          }
                                      ],
                              },
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"FLIGHT DETAILS";
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
