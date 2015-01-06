//
//  NJOPFlightsViewController.m
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPFlightsViewController.h"
#import "NJOPClient+flights.h"
#import "NJOPReservation.h"

@interface NJOPFlightsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation NJOPFlightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIRefreshControl *refreshMe = [[UIRefreshControl alloc] init];
    refreshMe.backgroundColor = [UIColor blackColor];
    refreshMe.tintColor = [UIColor whiteColor];
    refreshMe.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull Me"];
    [refreshMe addTarget:self action:@selector(refreshTable:)
        forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshMe;

}

- (void)refreshTable:(UIRefreshControl *)refreshMe
{
    refreshMe.attributedTitle = [[NSAttributedString alloc] initWithString:
                                 @"Refreshing data..."];
    NSLog(@"Refreshing!!");
    [refreshMe endRefreshing];
    refreshMe.attributedTitle = [[NSAttributedString alloc] initWithString:
                                 @"Refreshed"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource {
    
    __weak NJOPFlightsViewController* wself = self;
    
    [NJOPClient GETReservationsWithInfo:nil completion:^(NSArray *reservations, NSError *error) {
        [wself updateWithReservation:reservations];
    }];
}

-(void)updateWithReservation:(NSArray *)reservations {
    
    NSMutableArray *kSimpleDataSourceCells = [[NSMutableArray alloc] init];
    
    for (NJOPReservation *reservation in reservations) {
        NSMutableDictionary *kSimpleDataSourceKeys = [[NSMutableDictionary alloc] init];
        [kSimpleDataSourceKeys addEntriesFromDictionary:@{
                                                          kSimpleDataSourceCellIdentifierKey		: @"NJOPFlightTableCell",
                                                          kSimpleDataSourceCellKeypaths					: @{
                                                                  @"monthLabel.text" : @"AUG",
                                                                  @"dateLabel.text" : reservation.departureDateString, // placeholder value
                                                                  @"weekdayLabel.text" : @"Monday",
                                                                  @"toFBOLocationLabel.text" : reservation.arrivalAirportCity,
                                                                  @"fromFBOLocationLabel.text" : reservation.departureAirportCity,
                                                                  @"timeDurationLabel.text" : [NSString stringWithFormat:@"%@", reservation.estimatedTripTimeNumber], // placeholder value
                                                                  }
                                                          
                                         }];
        [kSimpleDataSourceCells addObject:kSimpleDataSourceKeys];
    }
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : kSimpleDataSourceCells,
                              },
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"FLIGHTS";
}
- (IBAction)segmentedControlAction:(id)sender {
    
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
