//
//  NJOPFlightsViewController.m
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPFlightsViewController.h"
#import "NJOPClient+flights.h"

@interface NJOPFlightsViewController ()

@end

@implementation NJOPFlightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource {
    
    __weak NJOPFlightsViewController* wself = self;
    
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
                                          kSimpleDataSourceCellIdentifierKey		: @"NJOPFlightTableCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"monthLabel.text" : @"AUG",
                                                  @"dateLabel.text" : @"4",
                                                  @"weekdayLabel.text" : @"Monday",
                                                  @"toFBOLocationLabel.text" : @"Naples",
                                                  //@"firstImageView.image" : nil;
                                                  @"fromFBOLocationLabel.text" : @"Teterboro",
                                                  @"timeDurationLabel.text" : @"12:00PM-2:45PM",

                                                  //@"secondImageView.image" : nil;
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
