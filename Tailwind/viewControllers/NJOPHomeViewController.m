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

@interface NJOPHomeViewController ()

@end

@implementation NJOPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    NJOPReservation *todaysReservations = reservations[0]; // only taking the first reservation
    NSLog(@"today's Reservation: %@",todaysReservations);
    NSDictionary* todaysFBO = @{
                                @"FBOTableCell" : @{
                                        @"toFBOTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",todaysReservations.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                        @"fromFBOTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",todaysReservations.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                        
                                        @"fromFBOAirpotCodeLabel.text"	: [NSString stringWithFormat:@"%@", todaysReservations.departureAirportId],
                                        @"toFBOAirpotCodeLabel.text"		: [NSString stringWithFormat:@"%@", todaysReservations.arrivalAirportId],
                                        @"fromFBOLocationLabel.text" : [NSString stringWithFormat:@"%@", todaysReservations.departureAirportCity],
                                        @"toFBOLocationLabel.text" : [NSString stringWithFormat:@"%@", todaysReservations.arrivalAirportCity],
                                        }
                                };
    
    
    NSDictionary *noFBO = @{
                            @"NJOPNOFBOTableCell" : @{
                                    @"rawData.text": [NSString stringWithFormat:@"%@",todaysReservations.rawData]
                                    },
                            @"NJOPTripCompleteCell" : @{
                                    @"completionGreetingLabel.text" : @"Welcome to Miami",
                                    @"groundOrdersLabel.text" : @"Pick up at 11:00PM",
                                    @"flightTimeLabel.text" : @"5hrs 20mins",
                                    @"projectedRemainingHoursLabel.text" : @"151",
                                    }
                            };
    
    NJOPReservation *nextReservations = reservations[2]; // getting the third flight here, this is messy
    NSLog(@"today's Reservation: %@",nextReservations);
    
    NSDictionary *upcomingFBO = @{
                                  @"NJOPUpcomingFlightTableCell" : @{
                                          @"arrivalAirportCityAndStateLabel.text" : @"Naples, FL",
                                          @"scheduledDepartureLabel.text" : @"Monday, August 28, 2014",
                                          @"departureTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",nextReservations.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                          @"arrivalTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",nextReservations.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                          @"departureAirportIdLabel.text"	: [NSString stringWithFormat:@"%@", nextReservations.departureAirportId],
                                          @"departureAirportCityLabel.text" : [NSString stringWithFormat:@"%@", nextReservations.departureAirportCity],
                                          @"arrivalAirportIdLabel.text"		: [NSString stringWithFormat:@"%@", nextReservations.arrivalAirportId],
                                          @"arrivalAirportCityLabel.text" : [NSString stringWithFormat:@"%@", nextReservations.arrivalAirportCity]
                                          }
                                  };
    
    NSDictionary *currentFBO = @{
                                 @"NJOPCurrentFBOTableCell" : @{
                                         @"departureTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",todaysReservations.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                         @"arrivalTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",todaysReservations.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                         @"departureAirportIdLabel.text"	: [NSString stringWithFormat:@"%@", todaysReservations.departureAirportId],
                                         @"departureAirportCityLabel.text" : [NSString stringWithFormat:@"%@", todaysReservations.departureAirportCity],
                                         @"arrivalAirportIdLabel.text"		: [NSString stringWithFormat:@"%@", todaysReservations.arrivalAirportId],
                                         @"arrivalAirportCityLabel.text" : [NSString stringWithFormat:@"%@", todaysReservations.arrivalAirportCity],
                                         @"estimatedFlightTimeLabel.text" : @"2hrs 7mins",
                                         @"estimatedTripTimeLabel.text" : @"2h 54m",
                                         }
                                 
                                 };
    
    NSArray*sections = @[
                         @{
                             kSimpleDataSourceSectionCellsKey : @[
                                     @{
                                         kSimpleDataSourceCellIdentifierKey			: @"FBOTableCell",
                                         kSimpleDataSourceCellKeypaths			 			: todaysFBO[@"FBOTableCell"],
                                         
                                         },
                                     @{
                                         kSimpleDataSourceCellIdentifierKey			: @"NJOPUpcomingFlightTableCell",
                                         kSimpleDataSourceCellKeypaths : upcomingFBO[@"NJOPUpcomingFlightTableCell"]
                                         },
                                     @{
                                         kSimpleDataSourceCellIdentifierKey			: @"NJOPCurrentFBOTableCell",
                                         kSimpleDataSourceCellKeypaths  : currentFBO[@"NJOPCurrentFBOTableCell"]
                                         },
                                     @{
                                         kSimpleDataSourceCellIdentifierKey			: @"NJOPNOFBOTableCell",
                                         kSimpleDataSourceCellKeypaths	:
                                             noFBO[@"NJOPNOFBOTableCell"]
                                         },
                                     @{
                                         kSimpleDataSourceCellIdentifierKey			: @"NJOPTripCompleteCell",
                                         kSimpleDataSourceCellKeypaths	:
                                             noFBO[@"NJOPTripCompleteCell"]
                                         }
                                     ],
                             },
                         ];
    NSLog(@"HERE");
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    NSLog(@"ASLKDJASLKDJASLDJSAL");
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
