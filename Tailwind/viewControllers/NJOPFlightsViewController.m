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
#import "NJOPSession.h"

@interface NJOPFlightsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray *reservations;
@end

@implementation NJOPFlightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIRefreshControl *refreshMe = [[UIRefreshControl alloc] init];
    refreshMe.backgroundColor = [UIColor clearColor];
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
    
    NJOPSession *session = [NJOPSession sharedInstance];
    
    __weak NJOPFlightsViewController* wself = self;

    [wself updateWithReservation:session.reservations];
}

- (NSInteger)extractDateFrom:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date];
    NSInteger day = [components day];
    
    return day;
}

-(void)updateWithReservation:(NSArray *)reservations {
    
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
    weekFormatter.dateFormat = @"EEEE";
    
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    monthFormatter.dateFormat = @"MMM";
    
    NSMutableArray *kSimpleDataSourceCells = [[NSMutableArray alloc] init];
    
    for (NJOPReservation *reservation in reservations) {
        NSMutableDictionary *kSimpleDataSourceKeys = [[NSMutableDictionary alloc] init];
        [kSimpleDataSourceKeys addEntriesFromDictionary:@{
                                                          kSimpleDataSourceCellIdentifierKey		: @"NJOPFlightTableCell",
                                                          kSimpleDataSourceCellKeypaths					: @{
                                                                  @"monthLabel.text" : [monthFormatter stringFromDate:reservation.departureDate],
                                                                  @"dateLabel.text" : [NSString stringWithFormat:@"%ld", (long)[self extractDateFrom:reservation.departureDate]], // placeholder value
                                                                  @"weekdayLabel.text" : [weekFormatter stringFromDate:reservation.departureDate],
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
    /* need to load contract flights vs individual's booked flights */
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self loadDataSource];
        [self.tableView reloadData];
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        NSArray *sections = @[
                              @{
                                  kSimpleDataSourceSectionCellsKey : @[
                                          @{
                                                                           kSimpleDataSourceCellIdentifierKey			: @"NJOPTableViewCell",
                                                                           }
                                          ],
                                  },
                              ];
        
        self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
        [self.tableView reloadData];
    } else {
        NSLog(@"How is this even possible?");
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *representationDict = [self.reservations objectAtIndex:indexPath.row];
    
    if ([segue.identifier isEqualToString:@"showDetail"] ) {
        
        NJOPFlightsDetailViewController *viewController = segue.destinationViewController;
        viewController.reservation = representationDict[@"CellItem"];
    }
}



@end
