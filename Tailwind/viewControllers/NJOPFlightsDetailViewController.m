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
                                                  @"firstDateLabel.text" : @"Mon, Oct 27, 2014",
                                                  @"firstLocationLabel.text" : @"Teterboro, NJ",
                                                  @"firstTimeLabel.text" : @"12:00PM EST",
                                                  @"firstTemperatureLabel.text" : @"60º",
                                                  //@"firstImageView.image" : nil;
                                                  @"secondDateLabel.text" : @"Mon, Oct 27, 2014",
                                                  @"secondLocationLabel.text" : @"Naples, FL",
                                                  @"secondTimeLabel.text" : @"2:45PM EST",
                                                  @"secondTemperatureLabel.text" : @"83º",
                                                  //@"secondImageView.image" : nil;
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Your Plane",
                                                  @"detailLabel.text" : @"Cessna Citation Encore+",
                                                  //																@"imgaeView" : @"",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Ground Transportation",
                                                  @"detailLabel.text" : @"Requested",
                                                  //																@"imgaeView" : @"",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Your Crew",
                                                  @"detailLabel.text" : @"Captain Brad Hanshaw",
                                                  //																@"imgaeView" : @"",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Passenger Manifest",
                                                  @"detailLabel.text" : @"2 Passengers",
                                                  //																@"imgaeView" : @"",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Catering",
                                                  @"detailLabel.text" : @"Requested",
                                                  //																@"imgaeView" : @"",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Advisory Notes",
                                                  @"detailLabel.text" : @"Please Read",
                                                  //																@"imgaeView" : @"",
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
