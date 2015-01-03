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
    [NJOPClient GETReservationWithInfo:info completion:^(NJOPReservation *reservation, NSError *error) {
        [wself updateWithReservations:@[reservation]];
    }];
}

-(void)updateWithReservations:(NSArray*)reservations {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, YYYY"];
    NSString* dateString = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@"\n Welcome My Smith"];
    
    
    NSLog(@"reservation is: %@",reservations);
    NJOPReservation* todaysReservations = reservations[0]; // only taking the first reservation
    NSLog(@"today's Reseration: %@",todaysReservations);
    NSDictionary* todaysFBO = @{
                                @"FBOTableCell" : @{
                                        //@"fromFBODateLabel.text"			: [NSString stringWithFormat:@"%@",todaysReservations.departureDateString],
                                        @"toFBOTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",todaysReservations.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                        @"fromFBOTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",todaysReservations.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                        
                                        @"fromFBOAirpotCodeLabel.text"	: [NSString stringWithFormat:@"%@", todaysReservations.departureAirportId],
                                        @"toFBOAirpotCodeLabel.text"		: [NSString stringWithFormat:@"%@", todaysReservations.arrivalAirportId],
                                        @"fromFBOLocationLabel.text" : [NSString stringWithFormat:@"%@", todaysReservations.departureAirportCity],
                                        @"toFBOLocationLabel.text" : [NSString stringWithFormat:@"%@", todaysReservations.arrivalAirportCity],
                                        
                                        //																	@"fromFBOTailNumberLabel.text"	: todaysReservations.tailNumber,
                                        //@"travelTimeLabel.text" 			: [NSString stringWithFormat:@"%@ %@", todaysReservations.travelTime, todaysReservations.stopsText],
                                        
                                        //																	@"fromFBOLocationLabel.text"		: todaysReservations.departureFboName,
                                        //																	@"toFBOLocationLabel.text"			: todaysReservations.arrivalFboName
                                        }
                                };
    
    
    NSDictionary *noFBO = @{
                            @"NJOPNOFBOTableCell" : @{
                                    @"rawData.text": [NSString stringWithFormat:@"%@",todaysReservations.rawData]
                                    },
                            @"NJOPTripCompleteCell" : @{
                                    }
                            };
    
    NSDictionary *upcomingFBO = @{
                                  @"NJOPUpcomingFlightTableCell" : @{
                                          @"toFBOTimeLabel.text" 				: [NSString stringWithFormat:@"%@",todaysReservations.departureTime],
                                          @"fromFBOTimeLabel.text" 					: [NSString stringWithFormat:@"%@",todaysReservations.arrivalTime],
                                          
                                          @"fromFBOAirportCodeLabel.text"	: [NSString stringWithFormat:@"%@, %@", todaysReservations.departureAirportId, todaysReservations.departureAirportCity],
                                          @"toFBOAirportCodeLabel.text"		: [NSString stringWithFormat:@"%@, %@", todaysReservations.arrivalAirportId, todaysReservations.arrivalAirportCity]
                                          }
                                  };
    
    NSDictionary *currentFBO = @{
                                 @"NJOPCurrentFBOTableCell" : @{
                                         @"toFBOTimeLabel.text" 				: [NSString stringWithFormat:@"%@",todaysReservations.departureTime],
                                         @"fromFBOTimeLabel.text" 					: [NSString stringWithFormat:@"%@",todaysReservations.arrivalTime],
                                         
                                         @"fromFBOAirportCodeLabel.text"	: [NSString stringWithFormat:@"%@, %@", todaysReservations.departureAirportId, todaysReservations.departureAirportCity],
                                         @"toFBOAirportCodeLabel.text"		: [NSString stringWithFormat:@"%@, %@", todaysReservations.arrivalAirportId, todaysReservations.arrivalAirportCity]
                                         }
                                 
                                 };
    
    NSArray*sections = @[
                         @{
                             kSimpleDataSourceSectionCellsKey : @[
                                     @{
                                         kSimpleDataSourceCellIdentifierKey			: @"FBOTableCell",
                                         kSimpleDataSourceCellKeypaths			 			: todaysFBO[@"FBOTableCell"]
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
