//
//  NJOPFlightsDetailViewController.m
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPFlightsDetailViewController.h"
#import "NJOPClient+flights.h"
#import "NJOPPassengeManifestViewController.h"
#import "NJOPGroundViewController.h"
#import "NJOPCateringViewController.h"

@interface NJOPFlightsDetailViewController ()

@end

@implementation NJOPFlightsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateWithReservation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)loadDataSource {
//    
//    __weak NJOPFlightsDetailViewController* wself = self;
//    
//    [NJOPClient GETReservationsWithInfo:nil completion:^(NSArray *reservations, NSError *error) {
//        [wself updateWithReservation:reservations];
//    }];
//}

-(void)updateWithReservation {
    
    NSDateFormatter* weatherFormatter = [[NSDateFormatter alloc] init];
    [weatherFormatter setDateFormat:@"EE MMM dd, YYYY"];
    
    NSDateFormatter *departureFormatter = [[NSDateFormatter alloc] init];
    [departureFormatter setDateFormat:@"MMMM dd, YYYY"];
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey		: @"NJOPFlightDetailCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"guaranteedAircraftTypeDescriptionLabel.text" : _reservation.aircraftType,
                                                  @"tailNumberLabel.text" : @"N618QS",
                                                  @"departureDateLabel.text" : [departureFormatter stringFromDate:_reservation.departureDate],
                                                  @"departureFBONameLabel.text" : _reservation.departureFboName,
                                                  @"departureTimeLabel.text" : [[NSString stringWithFormat:@"%@",_reservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                                  @"departureAirportIdLabel.text" : _reservation.departureAirportId,
                                                  @"departureAirportCityLabel.text" : [_reservation.departureAirportCity capitalizedString],
                                                  @"arrivalTimeLabel.text" : [[NSString stringWithFormat:@"%@",_reservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                                  @"arrivalAirportIdLabel.text" : _reservation.arrivalAirportId,
                                                  @"arrivalAirportCityLabel.text" : [_reservation.arrivalAirportCity capitalizedString],
                                                  @"arrivalFBONameLabel.text" : _reservation.arrivalFboName,
                                                  @"departureWeatherDateLabel.text" : [weatherFormatter stringFromDate:_reservation.departureDate],
                                                  @"departureAirportCityAndStateLabel.text" : [_reservation.departureAirportCity capitalizedString],
                                                  @"departureWeatherTimeLabel.text" : [[NSString stringWithFormat:@"%@",_reservation.departureTime] substringWithRange:NSMakeRange(0, 7)],
                                                  @"departureTemperatureLabel.text" : @"39°",
                                                  @"arrivalWeatherDateLabel.text" : [weatherFormatter stringFromDate:_reservation.arrivalDate],
                                                  @"arrivalAirportCityAndStateLabel.text" : [_reservation.arrivalAirportCity capitalizedString],
                                                  @"arrivalWeatherTimeLabel.text" : [[NSString stringWithFormat:@"%@",_reservation.arrivalTime] substringWithRange:NSMakeRange(0, 7)],
                                                  @"arrivalTemperatureLabel.text" : @"85°",
                                                  }
                                          },
//                                      @{
//                                          kSimpleDataSourceCellIdentifierKey			: @"NJOPInfoCell",
//                                          kSimpleDataSourceCellKeypaths					: @{
//                                                  @"topLabel.text" : @"Your Plane",
//                                                  @"detailLabel.text" : @"Cessna Citation Encore+",
//                                                  }
//                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"GroundInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Ground Transportation",
                                                  @"detailLabel.text" : @"Requested",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"CrewInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Your Crew",
                                                  @"detailLabel.text" : @"Captain Brad Hanshaw",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"PassengerManifestInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Passenger Manifest",
                                                  @"detailLabel.text" : @"2 Passengers",
                                                  },
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"CateringInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Catering",
                                                  @"detailLabel.text" : @"Requested",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"AdvisoryNotesInfoCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"topLabel.text" : @"Advisory Notes",
                                                  @"detailLabel.text" : @"Please Read",
                                                  }
                                          }
                                      ],
                              },
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"FLIGHT DETAILS";
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showManifest"]) {
        NJOPPassengeManifestViewController *vc = [segue destinationViewController];
        vc.reservation = self.reservation;
    } else if ([segue.identifier isEqualToString:@"showGround"]) {
        NJOPGroundViewController *vc = [segue destinationViewController];
        vc.reservation = self.reservation;
    } else if ([segue.identifier isEqualToString:@"showCatering"]) {
        NJOPCateringViewController *vc = [segue destinationViewController];
        vc.reservation = self.reservation;
    }
}


@end
