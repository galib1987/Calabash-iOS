//
//  NJOPHomeViewController.m
//  Tailwind
//
//  Created by netjets on 12/18/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPHomeViewController.h"
#import "NCLInfoPresenter.h"
#import "NJOPReservation.h"
#import "NNNOAuthClient.h"
#import "NJOPClient.h"
#import "NJOPFlightsDetailViewController.h"
#import "NJOPNavigationBar.h"

@interface NJOPHomeViewController ()
@property (strong, nonatomic) NSArray *reservations;
@property (strong, nonatomic) NSArray *sections;
@end

@implementation NJOPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource {
    
    __weak NJOPHomeViewController* wself = self;
    
    NSDictionary *info = nil;
    if (USE_STATIC_DATA == 0) {
        NNNOAuthClient *userSession = [NNNOAuthClient sharedInstance];
        NSString *accessToken = userSession.credential.accessToken;
        NSString *urlString = [NSString stringWithFormat:@"https://%@%@?appAgent=%@&access_token=%@",API_HOSTNAME, URL_BRIEF,API_SOURCE_IDENTIFIER,accessToken];
        if ([urlString length] > 20) {
            info = [NSDictionary dictionaryWithObjectsAndKeys:urlString,@"apiURL", API_HOSTNAME, @"host",nil];
        }
    }
    [NJOPClient GETReservationsWithInfo:info completion:^(NSArray *reservations, NSError *error) {
        [wself updateWithReservations:reservations];
    }];
}

-(void)updateWithReservations:(NSArray*)reservations {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, YYYY"];
//    NSString* dateString = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@"\n Welcome My Smith"];
    
    NJOPReservation *firstReservation = reservations[0];
    NJOPReservation *secondReservation = reservations[1];
    NJOPReservation *thirdReservation = reservations[2];
    
    NSDictionary* todaysFBO = @{
                                @"FBOTableCell" : @{
                                        @"toFBOTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",firstReservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                        @"fromFBOTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",firstReservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                        
                                        @"fromFBOAirpotCodeLabel.text"	: [NSString stringWithFormat:@"%@", firstReservation.departureAirportId],
                                        @"toFBOAirpotCodeLabel.text"		: [NSString stringWithFormat:@"%@", firstReservation.arrivalAirportId],
                                        @"fromFBOLocationLabel.text" : [NSString stringWithFormat:@"%@", firstReservation.departureAirportCity],
                                        @"toFBOLocationLabel.text" : [NSString stringWithFormat:@"%@", firstReservation.arrivalAirportCity],
                                        }
                                };
    

    
    NSDictionary *upcomingFBO = @{
                                  @"NJOPUpcomingFlightTableCell" : @{
                                          @"arrivalAirportCityAndStateLabel.text" : secondReservation.departureAirportCity,
                                          @"scheduledDepartureLabel.text" : @"Monday, August 28, 2014",
                                          @"departureTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",secondReservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                          @"arrivalTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",secondReservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                          @"departureAirportIdLabel.text"	: [NSString stringWithFormat:@"%@", secondReservation.departureAirportId],
                                          @"departureAirportCityLabel.text" : [NSString stringWithFormat:@"%@", secondReservation.departureAirportCity],
                                          @"arrivalAirportIdLabel.text"		: [NSString stringWithFormat:@"%@", secondReservation.arrivalAirportId],
                                          @"arrivalAirportCityLabel.text" : [NSString stringWithFormat:@"%@", secondReservation.arrivalAirportCity]
                                          }
                                  };
    
    NSDictionary *currentFBO = @{
                                 @"NJOPCurrentFBOTableCell" : @{
                                         @"departureTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",thirdReservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                         @"arrivalTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",thirdReservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                         @"departureAirportIdLabel.text"	: [NSString stringWithFormat:@"%@", thirdReservation.departureAirportId],
                                         @"departureAirportCityLabel.text" : [NSString stringWithFormat:@"%@", thirdReservation.departureAirportCity],
                                         @"arrivalAirportIdLabel.text"		: [NSString stringWithFormat:@"%@", thirdReservation.arrivalAirportId],
                                         @"arrivalAirportCityLabel.text" : [NSString stringWithFormat:@"%@", thirdReservation.arrivalAirportCity],
                                         @"estimatedFlightTimeLabel.text" : @"2hrs 7mins",
                                         @"estimatedTripTimeLabel.text" : @"2h 54m",
                                         }
                                 
                                 };
    
    NSDictionary *noFBO = @{
                            @"NJOPNOFBOTableCell" : @{
                                    @"rawData.text": [NSString stringWithFormat:@"%@", thirdReservation.rawData]
                                    },
                            @"NJOPTripCompleteCell" : @{
                                    @"completionGreetingLabel.text" : [[NSString stringWithFormat:@"Welcome to %@", thirdReservation.arrivalAirportCity] lowercaseString],
                                    @"groundOrdersLabel.text" : @"Pick up at 11:00PM",
                                    @"flightTimeLabel.text" : @"5hrs 20mins",
                                    @"projectedRemainingHoursLabel.text" : @"151",
                                    }
                            };
    
    NSArray *sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"FBOTableCell",
                                          kSimpleDataSourceCellKeypaths			 			: todaysFBO[@"FBOTableCell"],
                                          kSimpleDataSourceCellItem : firstReservation,
                                          
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPUpcomingFlightTableCell",
                                          kSimpleDataSourceCellKeypaths : upcomingFBO[@"NJOPUpcomingFlightTableCell"],
                                          kSimpleDataSourceCellItem : secondReservation,
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPCurrentFBOTableCell",
                                          kSimpleDataSourceCellKeypaths  : currentFBO[@"NJOPCurrentFBOTableCell"],
                                          kSimpleDataSourceCellItem : thirdReservation,
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPNOFBOTableCell",
                                          kSimpleDataSourceCellKeypaths	:
                                              noFBO[@"NJOPNOFBOTableCell"],
                                          kSimpleDataSourceCellItem : thirdReservation,
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPTripCompleteCell",
                                          kSimpleDataSourceCellKeypaths	:
                                              noFBO[@"NJOPTripCompleteCell"],
                                          kSimpleDataSourceCellItem : thirdReservation,
                                          }
                                      ],
                              },
                          ];

    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.headerFooterCellIdentifiers = @[@"SummaryHeaderView"];
    /*
    [self.dataSource setConfigureHeaderFooterViewBlock:^(UIView *headerView) {
        if ([headerView isKindOfClass:[NJOPSummaryViewTopHeaderView class]]) {
            NJOPSummaryViewTopHeaderView* tableHeaderView = (NJOPSummaryViewTopHeaderView*)headerView;
            tableHeaderView.topLabelView.text = dateString;
            tableHeaderView.bodyLabelView.text = @"Hello Ms. Smith";
            [tableHeaderView layoutIfNeeded];
        }
    }];
     */
    
}


- (IBAction)viewFlightDetailsTapped:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Flights" bundle:nil];
    NJOPFlightsDetailViewController *flightDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"FlightDetailVC"];
    
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    NSDictionary *dataDict = [self.dataSource.sections[0][kSimpleDataSourceSectionCellsKey] objectAtIndex:indexPath.row];
    NJOPReservation *reservationToPass = dataDict[@"CellItem"];
    flightDetailVC.reservation = reservationToPass;
    
    NSLog(@"PASSING THIS: %@", dataDict);
    
    [self.navigationController pushViewController:flightDetailVC animated:YES];
    
}

@end
