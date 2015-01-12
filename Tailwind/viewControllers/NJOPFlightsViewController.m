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
#import "NJOPFlightsDetailViewController.h"

@interface NJOPFlightsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray *reservations;
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
                                                                  @"monthLabel.text" : @"JAN",
                                                                  @"dateLabel.text" : [NSString stringWithFormat:@"%@", [reservation.departureDateString substringWithRange:NSMakeRange(4, 2)]], // placeholder value
                                                                  @"weekdayLabel.text" : @"Wednesday",
                                                                  @"toFBOLocationLabel.text" : reservation.arrivalAirportCity,
                                                                  @"fromFBOLocationLabel.text" : reservation.departureAirportCity,
                                                                  @"timeDurationLabel.text" : @"12:00PM - 2:45AM", // placeholder value
                                                                  },
                                                          kSimpleDataSourceCellItem : reservation,
                                                          kSimpleDataSourceCellSegueAction : @"showDetail",
                                                          
                                         }];
        
        [kSimpleDataSourceCells addObject:kSimpleDataSourceKeys];
    }
    
    self.reservations = kSimpleDataSourceCells;
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *representationDict = [self.reservations objectAtIndex:indexPath.row];
    NSLog(@"HEY HEY HEY HEY %@", representationDict);
    
    if ([segue.identifier isEqualToString:@"showDetail"] ) {
        
        NJOPFlightsDetailViewController *viewController = segue.destinationViewController;
        viewController.reservation = representationDict[@"CellItem"];
    }
}



@end
