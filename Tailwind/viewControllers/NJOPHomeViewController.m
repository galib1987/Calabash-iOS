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
#import <DateTools/NSDate+DateTools.h>

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
    
    NSDictionary *FBORepresentation = [[NSDictionary alloc] init];
    NSDictionary *sectionCellRepresentation = [[NSDictionary alloc] init];
    
    
    /*needs to be refactored into a method. also deciding what date conditions should be. */
    if (reservations) {
        NJOPReservation *reservation = reservations[0]; // only interested in the next flight schedule
        
        reservation.departureDate = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]];
        NSLog(@"%@", reservation.departureDate);
        
        if ([reservation.departureDate laterDate:[NSDate date]]) {
            
            FBORepresentation = @{
                                  @"FBOTableCell" : @{
                                          @"toFBOTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",reservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                          @"fromFBOTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",reservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                          
                                          @"fromFBOAirpotCodeLabel.text"	: [NSString stringWithFormat:@"%@", reservation.departureAirportId],
                                          @"toFBOAirpotCodeLabel.text"		: [NSString stringWithFormat:@"%@", reservation.arrivalAirportId],
                                          @"fromFBOLocationLabel.text" : [NSString stringWithFormat:@"%@", reservation.departureAirportCity],
                                          @"toFBOLocationLabel.text" : [NSString stringWithFormat:@"%@", reservation.arrivalAirportCity],
                                          }
                                  };
            
            sectionCellRepresentation =                                       @{
                                                                                kSimpleDataSourceCellIdentifierKey			: @"FBOTableCell",
                                                                                kSimpleDataSourceCellKeypaths			 			: FBORepresentation[@"FBOTableCell"],
                                                                                kSimpleDataSourceCellItem : reservation,
                                                                                
                                                                                };
        } else if ([reservation.departureDate isTomorrow]) {
            
            FBORepresentation = @{
                                  @"NJOPUpcomingFlightTableCell" : @{
                                          @"arrivalAirportCityAndStateLabel.text" : reservation.departureAirportCity,
                                          @"scheduledDepartureLabel.text" : @"Monday, August 28, 2014",
                                          @"departureTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",reservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                          @"arrivalTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",reservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                          @"departureAirportIdLabel.text"	: [NSString stringWithFormat:@"%@", reservation.departureAirportId],
                                          @"departureAirportCityLabel.text" : [NSString stringWithFormat:@"%@", reservation.departureAirportCity],
                                          @"arrivalAirportIdLabel.text"		: [NSString stringWithFormat:@"%@", reservation.arrivalAirportId],
                                          @"arrivalAirportCityLabel.text" : [NSString stringWithFormat:@"%@", reservation.arrivalAirportCity]
                                          }
                                  };
            
            sectionCellRepresentation =                                       @{
                                                                                kSimpleDataSourceCellIdentifierKey			: @"NJOPUpcomingFlightTableCell",
                                                                                kSimpleDataSourceCellKeypaths : FBORepresentation[@"NJOPUpcomingFlightTableCell"],
                                                                                kSimpleDataSourceCellItem : reservation,
                                                                                };
            
            
        } else if ([reservation.departureDate isToday]) {
            
            
            FBORepresentation = @{
                                  @"NJOPCurrentFBOTableCell" : @{
                                          @"departureTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",reservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                          @"arrivalTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",reservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                          @"departureAirportIdLabel.text"	: [NSString stringWithFormat:@"%@", reservation.departureAirportId],
                                          @"departureAirportCityLabel.text" : [NSString stringWithFormat:@"%@", reservation.departureAirportCity],
                                          @"arrivalAirportIdLabel.text"		: [NSString stringWithFormat:@"%@", reservation.arrivalAirportId],
                                          @"arrivalAirportCityLabel.text" : [NSString stringWithFormat:@"%@", reservation.arrivalAirportCity],
                                          @"estimatedFlightTimeLabel.text" : @"2hrs 7mins",
                                          @"estimatedTripTimeLabel.text" : @"2h 54m",
                                          }
                                  
                                  };
            
            sectionCellRepresentation =                                       @{
                                                                                kSimpleDataSourceCellIdentifierKey			: @"NJOPCurrentFBOTableCell",
                                                                                kSimpleDataSourceCellKeypaths : FBORepresentation[@"NJOPCurrentFBOTableCel"],
                                                                                kSimpleDataSourceCellItem : reservation,
                                                                                };
            
        }
    } else {
        
        // show the no flights booked cell
        FBORepresentation = @{
                              @"NJOPNOFBOTableCell" : @{
                                      //                                        @"rawData.text": [NSString stringWithFormat:@"%@", reservation.rawData]
                                      },
                              //                                @"NJOPTripCompleteCell" : @{
                              //                                        @"completionGreetingLabel.text" : [[NSString stringWithFormat:@"Welcome to %@", reservation.arrivalAirportCity] lowercaseString],
                              //                                        @"groundOrdersLabel.text" : @"Pick up at 11:00PM",
                              //                                        @"flightTimeLabel.text" : @"5hrs 20mins",
                              //                                        @"projectedRemainingHoursLabel.text" : @"151",
                              //                                        }
                              //                                };
                              
                              };
        
        sectionCellRepresentation =                                       @{
                                                                            kSimpleDataSourceCellIdentifierKey			: @"NJOPNOFBOTableCell",
                                                                            kSimpleDataSourceCellKeypaths : FBORepresentation[@"NJOPNOFBOTableCell"],
                                                                            };
    }
    
    
    NSArray *sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      sectionCellRepresentation,
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
