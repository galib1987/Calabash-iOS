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
#import "NJOPDetailViewController.h"
#import "NJOPOAuthClient.h"
#import "NJOPFlightHTTPClient.h"
#import "NJOPSelectAccountViewController.h"
#import "NJOPAccountViewController.h"

@interface NJOPFlightsViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray *cellsForReservations;
@end

@implementation NJOPFlightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self hideRefreshControl];
    
    // Do any additional setup after loading the view.
    [self setupRefreshControl];

}

- (void)hideRefreshControl {
    CGFloat containerInset = -(self.topView.frame.size.height * 2/3) + 0.8f;
    [self.tableView setContentInset:UIEdgeInsetsMake(containerInset, 0.0f, 0.0f, 0.0f)];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGFloat currentOffset = self.tableView.contentOffset.y;
    
    if (currentOffset >= self.topView.frame.size.height/3) {
        [self.tableView setContentInset:UIEdgeInsetsZero];
    }
}

- (void)setupRefreshControl {
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
    
    NJOPOAuthClient *session = [NJOPOAuthClient sharedInstance];
    
    __weak NJOPFlightsViewController* wself = self;
    
    [wself updateWithReservation:session.reservations];
}

- (NSInteger)extractDateFrom:(NSDate *)date {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date];
    NSInteger day = [components day];
    
    return day;
}

- (NSDictionary *)flightCellFromReservation:(NJOPReservation *)reservation {
    
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
    weekFormatter.dateFormat = @"EEEE";
    
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    monthFormatter.dateFormat = @"MMM";
    
    NSDictionary *cellRepresentation = @{
                                         kSimpleDataSourceCellIdentifierKey		: @"FlightTableCell",
                                         kSimpleDataSourceCellKeypaths					: @{
                                                 @"monthLabel.text" : [monthFormatter stringFromDate:reservation.departureDate],
                                                 @"dateLabel.text" : [NSString stringWithFormat:@"%ld", (long)[self extractDateFrom:reservation.departureDate]], // placeholder value
                                                 @"weekdayLabel.text" : [weekFormatter stringFromDate:reservation.departureDate],
                                                 @"toFBOLocationLabel.text" : [reservation.departureAirportCity capitalizedString],
                                                 @"fromFBOLocationLabel.text" : reservation.arrivalAirportCity,
                                                 @"timeDurationLabel.text" : @"12:00PM - 2:45AM", // placeholder value
                                                 },
                                         kSimpleDataSourceCellItem : reservation,
                                         
                                         };
    
    return cellRepresentation;
}

- (NSDictionary *)pendingCellFromReservation {
    NSDictionary *cellRepresentation = @{
                                         kSimpleDataSourceCellIdentifierKey		: @"PendingCell",
                                         kSimpleDataSourceCellKeypaths					: @{
                                                 @"monthLabel.text" : @"FEB",
                                                 @"dateLabel.text" : @"30", // placeholder value
                                                 @"weekdayLabel.text" : @"Tuesday",
                                                 @"toFBOLocationLabel.text" : @"CAIRO",
                                                 @"fromFBOLocationLabel.text" : @"Brisbane",
                                                 @"timeDurationLabel.text" : @"12:00PM - 2:45AM", // placeholder value
                                                 },
                                         
                                         };
    return cellRepresentation;
}

- (NSArray *)sectionsFromReservations:(NSArray *)reservations {
    NSMutableArray *sectionsArray = [[NSMutableArray alloc] init];
    
    for (NJOPReservation *reservation in reservations) {
        NSDictionary *cellRepresentation = [self flightCellFromReservation:reservation];
        [sectionsArray addObject:cellRepresentation];
    }
    
    [sectionsArray addObject:[self pendingCellFromReservation]]; // temp until we get pending flights back
    
    return sectionsArray;
}


-(void)updateWithReservation:(NSArray *)reservations {
    
    
    
    self.cellsForReservations = [self sectionsFromReservations:reservations];
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : self.cellsForReservations,
                              },
                          ];
    
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"FLIGHTS";
    
    
}

#pragma mark -- BUTTON ACTIONS

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
                                              kSimpleDataSourceCellIdentifierKey			: @"NoAccountFlights",
                                              }
                                          ],
                                  },
                              ];
        
        self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
        [self.tableView reloadData];
    }
}

- (IBAction)viewPastFlightsPressed:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Account" bundle:nil];
    NJOPAccountViewController *pastFlightsVC = [storyboard instantiateInitialViewController];
    
    [self.navigationController pushViewController:pastFlightsVC animated:YES];
}

- (IBAction)bookNewFlightPressed:(id)sender {
    NSLog(@"BEING PRESSED.");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    NJOPSelectAccountViewController *selectAccountVC = [storyboard instantiateViewControllerWithIdentifier:@"BookingSelectAccount"];
    
    [self.navigationController pushViewController:selectAccountVC animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *representationDict = [self.cellsForReservations objectAtIndex:indexPath.row];
    
    if ([segue.identifier isEqualToString:@"showDetail"] ) {
        
        NJOPDetailViewController *viewController = segue.destinationViewController;
        viewController.reservation = representationDict[@"CellItem"];
    }
}



@end
