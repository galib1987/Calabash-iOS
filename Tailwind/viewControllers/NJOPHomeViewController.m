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
#import "NJOPClient.h"
#import "NJOPDetailViewController.h"
#import "NJOPNavigationBar.h"
#import <DateTools/NSDate+DateTools.h>
#import "NJOPSummaryViewTopHeaderView.h"
#import "NJOPOAuthClient.h"
#import "NJOPSelectAccountViewController.h"
#import "NJOPIntrospector.h"
#import "NJOPResigner.h"
#import "NJOPFlightHTTPClient.h"

@interface NJOPHomeViewController ()
@end

@implementation NJOPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // listen for data
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataSource) name:kBriefLoadSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataSource) name:kBriefLoadSuccessNotification object:nil];
    
    self.coverView = [UIView new];
    self.coverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.7];
    self.coverView.frame = self.view.bounds;
    UILabel* label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.text = @"Loading";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = self.coverView.bounds;
    [self.coverView addSubview:label];
    [self.coverView setUserInteractionEnabled:NO];
    
    [NJOPResigner globalResignFirstResponder]; // temporary solution to keyboard on login

    [self.view addSubview:self.coverView];
    NJOPOAuthClient *session = [NJOPOAuthClient sharedInstance];
    if (session.reservations == nil) {
        [self start]; // we're going to start by seeing if we need to load stuff
    } else {
        [self loadDataSource];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    //
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actually loading the data in
- (void) start {
    NJOPFlightHTTPClient *client = [NJOPFlightHTTPClient sharedInstance];
    [client loadBrief];
}

#pragma mark -- SimpleDataSource

-(void)loadDataSource {
    
    NJOPOAuthClient *session = [NJOPOAuthClient sharedInstance];
    NSLog(@"loading from: %@",session.reservations);
    [self updateWithReservations:session.reservations];
    [UIView animateWithDuration:0.2 animations:^{
        [self.coverView setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
    }];
}

- (BOOL)hasUpcomingFlight:(NJOPReservation *)reservation {
    if ([reservation.departureDate isLaterThan:[NSDate date]]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)hasCurrentFlight:(NJOPReservation *)reservation {
    if ([reservation.departureDate isEarlierThan:[NSDate date]] && [reservation.arrivalDate isLaterThan:[NSDate date]]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDictionary *)createUpcomingFlightCell:(NJOPReservation *)reservation {
    NSDictionary *cellKeyPathsDict =
    @{
      @"FBOTableCell" : @{
              @"toFBOTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",reservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
              @"fromFBOTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",reservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
              
              @"fromFBOAirpotCodeLabel.text"	: [NSString stringWithFormat:@"%@", reservation.departureAirportId],
              @"toFBOAirpotCodeLabel.text"		: [NSString stringWithFormat:@"%@", reservation.arrivalAirportId],
              @"fromFBOLocationLabel.text" : [[NSString stringWithFormat:@"%@", reservation.departureAirportCity] capitalizedString],
              @"toFBOLocationLabel.text" : [[NSString stringWithFormat:@"%@", reservation.arrivalAirportCity] capitalizedString],
              }
                                       };
    // NOTE: Layout of FBOTableCell can be changed by setting its property 'flightInfoAvailable' to a combination of the flags 'tailNumber' and 'groundTransport'
    
    NSDictionary *dataSourceCellDict =
    @{
      kSimpleDataSourceCellIdentifierKey			: @"FBOTableCell",
      kSimpleDataSourceCellKeypaths			 			: cellKeyPathsDict[@"FBOTableCell"],
      kSimpleDataSourceCellItem : reservation,
      
      };
    
    return dataSourceCellDict;

}


- (NSDictionary *)createCurrentFlightCell:(NJOPReservation *)reservation {
    NSDictionary *cellKeyPathsDict =
    @{
      @"NJOPCurrentFBOTableCell" : @{
              @"departureTimeLabel.text" 				: [[NSString stringWithFormat:@"%@",reservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
              @"arrivalTimeLabel.text" 					: [[NSString stringWithFormat:@"%@",reservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
              @"departureAirportIdLabel.text"	: [NSString stringWithFormat:@"%@", reservation.departureAirportId],
              @"departureAirportCityLabel.text" : [[NSString stringWithFormat:@"%@", reservation.departureAirportCity] capitalizedString],
              @"arrivalAirportIdLabel.text"		: [NSString stringWithFormat:@"%@", reservation.arrivalAirportId],
              @"arrivalAirportCityLabel.text" : [[NSString stringWithFormat:@"%@", reservation.arrivalAirportCity] capitalizedString],
              @"estimatedFlightTimeLabel.text" : @"2hrs 7mins",
              @"estimatedTripTimeLabel.text" : @"2h 54m",
              }
      
      };
    
    NSDictionary *dataSourceCellDict = @{
      kSimpleDataSourceCellIdentifierKey			: @"NJOPCurrentFBOTableCell",
      kSimpleDataSourceCellKeypaths : cellKeyPathsDict[@"NJOPCurrentFBOTableCell"],
      kSimpleDataSourceCellItem : reservation,
      };
    
    return dataSourceCellDict;

}

- (NSDictionary *)createNoFlightsCell {
    
    NSDictionary *dataSourceCellDict =@{
      kSimpleDataSourceCellIdentifierKey			: @"NJOPNOFBOTableCell"
      };
    
    return dataSourceCellDict;
}



-(void)updateWithReservations:(NSArray*)reservations {
    NSLog(@"updateWithReservations");
    NSDictionary *cardDisplayedRepresentation = [[NSDictionary alloc] init];
    
    if ([NJOPIntrospector isObjectArray:reservations]) {
        NSLog(@"reservations is: %@:",reservations);
        NJOPReservation *reservation = reservations[0]; // only interested in the next flight schedule
        
        if ([self hasUpcomingFlight:reservation]) {
            
            cardDisplayedRepresentation = [self createUpcomingFlightCell:reservation];
           
        } else if ([self hasCurrentFlight:reservation]) {
            cardDisplayedRepresentation = [self createCurrentFlightCell:reservation];
            
        }
    } else { // NO RESERVATIONS
        cardDisplayedRepresentation = [self createNoFlightsCell];
    }
    
    
    NSArray *sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      cardDisplayedRepresentation,
                                      ],
                              },
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"NETJETS";
    self.dataSource.headerFooterCellIdentifiers = @[@"SummaryHeaderView"];
    
    
}


- (IBAction)viewFlightDetailsTapped:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Flights" bundle:nil];
    NJOPDetailViewController *flightDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"FlightDetailVC"];
    
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    NSDictionary *dataDict = [self.dataSource.sections[0][kSimpleDataSourceSectionCellsKey] objectAtIndex:indexPath.row];
    NJOPReservation *reservationToPass = dataDict[@"CellItem"];
    flightDetailVC.reservation = reservationToPass;

    if (self.navigationController != nil) {
        [self.navigationController pushViewController:flightDetailVC animated:YES];
    } else {
        NSLog(@"flight detail");
        NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Flights",menuStoryboardName,@"FlightDetailVC",menuViewControllerName, [NSNumber numberWithInt:isContainerScreen], appStoryboardIdentifier, reservationToPass, requestedReservationObject, nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif]; // using NSNotifications for menu changes because we also need to do other things in other places
    }
    
}

- (IBAction)bookFlightTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    NJOPSelectAccountViewController *selectAccountVC = [storyboard instantiateViewControllerWithIdentifier:@"BookingSelectAccount"];
    
    [self.navigationController pushViewController:selectAccountVC animated:YES];
}

@end
