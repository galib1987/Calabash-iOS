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
#import "NJOPCrewViewController.h"
#import "NJOPPlaneViewController.h"
#import "NJOPIntrospector.h"
#import "NJOPAdvisoryNotesController.h"
#import "NJOPAirportPM.h"
#import <NCLPersistenceUtil.h>
#import "NJOPTailwindPM.h"

@interface NJOPFlightsDetailViewController ()
@property (nonatomic) CGFloat affixedY;
@property (nonatomic) NSMutableArray *viewsToRemoveOnPush;
@end

@implementation NJOPFlightsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
    if (self.reservation == nil) {
        // see if we can get reservation from appDelegate
        AppDelegate *ad = (AppDelegate *)([UIApplication sharedApplication].delegate);
        if (ad.selectedReservation != nil) {
            self.reservation = ad.selectedReservation;
        }
    }
    
    [self getInfoForDropdown];
    
//    NJOPTitleSummaryViewController *titleSummaryVC = [[NJOPTitleSummaryViewController alloc] initWithNibName:@"NJOPTitleSummaryViewController" bundle:nil];
//    [self.tableView addSubview:titleSummaryVC.view];
//    [self.tableView setTableHeaderView:titleSummaryVC.view];

//    UIView *reservationView = [[UIView alloc] init];
//    reservationView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50.0f);
//    reservationView.backgroundColor = [UIColor grayColor];
//    _affixedY = reservationView.frame.size.height;
//    _viewsToRemoveOnPush = reservationView;
//    [self.tableView setContentInset:UIEdgeInsetsMake(_affixedY, 0, 0, 0)];
//    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addView)];
//    [reservationView addGestureRecognizer:tapGesture];
//
//    [self.parentViewController.view addSubview:reservationView];
    
    [self loadDataSource];
}

- (void)addView {
    UIView *additionalView = [[UIView alloc] init];
    additionalView.frame = CGRectMake(0, _affixedY, self.view.frame.size.width, 44.0f);
    additionalView.backgroundColor = [UIColor blackColor];
    additionalView.layer.opacity = 0.8;
    _affixedY = _affixedY + additionalView.frame.size.height;
    _viewsToRemoveOnPush = additionalView;
    [self.tableView setContentInset:UIEdgeInsetsMake(_affixedY, 0, 0, 0)];
    [self.parentViewController.view addSubview:additionalView];
    
}

- (void)getInfoForDropdown {
    NJOPTailwindPM *persistenceManager = [NJOPTailwindPM sharedInstance];
    NJOPReservation2 *reservation = [persistenceManager reservationForID:self.reservation.reservationId createIfNeeded:NO moc:persistenceManager.mainMOC];
    NSLog(@"%@", reservation.reservationID); // reservation id
    
    NSArray* requestsForReservation = [reservation.requests allObjects];
    NSLog(@"%lu", (unsigned long)[requestsForReservation count]); // how many requests
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EE MMM dd, YYYY"];
    
    for (NJOPRequest2 *request in requestsForReservation) {
        NSArray *legsArray = [request.legs allObjects];
        for (NJOPLeg *leg in legsArray) {
            NSLog(@"%@ %@ %@", [formatter stringFromDate:leg.depTime], leg.depLocation.airportName, leg.arrLocation.airportName);
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSDictionary *)detailCellFromReservation:(NJOPReservation *)reservation {
    NSDateFormatter* weatherFormatter = [[NSDateFormatter alloc] init];
    [weatherFormatter setDateFormat:@"EE MMM dd, YYYY"];
    
    NSDateFormatter *departureFormatter = [[NSDateFormatter alloc] init];
    [departureFormatter setDateFormat:@"MMMM dd, YYYY"];
    
    NSDictionary *cellRepresentation = @{
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
                                         };
    return cellRepresentation;
    
}

- (NSDictionary *)infoCellWithIdentifier:(NSString *)identifier topLabel:(NSString *)topLabel detailLabel:(NSString *)detailLabel icon:(UIImage *)image {
    NSDictionary *cellRepresentation = @{
                                         kSimpleDataSourceCellIdentifierKey			: identifier,
                                         kSimpleDataSourceCellKeypaths					: @{
                                                 @"topLabel.text" : topLabel,
                                                 @"detailLabel.text" : detailLabel,
                                                 @"imageView.image" : image
                                                 }
                                         };
    return cellRepresentation;
}


- (void)loadDataSource {
    
    if (self.reservation == nil) {
        // see if we can get reservation from appDelegate
        AppDelegate *ad = (AppDelegate *)([UIApplication sharedApplication].delegate);
        if (ad.selectedReservation != nil) {
            self.reservation = ad.selectedReservation;
        }
    }
    
    NSUInteger passengerCount = self.reservation.passengers.count;
    NSString *passengerCountString = passengerCount <= 1? [NSString stringWithFormat:@"%lu passenger", (unsigned long)passengerCount] : [NSString stringWithFormat:@"%lu passengers", (unsigned long)passengerCount];
    
    NSMutableArray *conditionalSectionsArray = [[NSMutableArray alloc] initWithObjects:
                                                [self detailCellFromReservation:_reservation],
                                                [self infoCellWithIdentifier:@"CrewInfoCell" topLabel:@"Your Crew" detailLabel:@"Captain Michael Chapman" icon:[UIImage imageNamed:@"crew"]],
                                                [self infoCellWithIdentifier:@"PassengerManifestInfoCell" topLabel:@"Passenger Manifest" detailLabel:passengerCountString icon:[UIImage imageNamed:@"passengers"]],
                                                nil];
    
    if ([NJOPIntrospector isObjectArray:_reservation.cateringOrders]) {
        [conditionalSectionsArray addObject:[self infoCellWithIdentifier:@"CateringInfoCell" topLabel:@"Catering" detailLabel:@"Details Enclosed" icon:[UIImage imageNamed:@"catering"]]];
    }
    
    if ([NJOPIntrospector isObjectArray:_reservation.groundOrders]) {
        [conditionalSectionsArray addObject:[self infoCellWithIdentifier:@"GroundInfoCell" topLabel:@"Ground Transportation" detailLabel:@"On Departure & Arrival" icon:[UIImage imageNamed:@"ground-transportation"]]];
    }
    
    [conditionalSectionsArray addObjectsFromArray:@[
                                                    [self infoCellWithIdentifier:@"AdvisoryNotesInfoCell" topLabel:@"Advisory Notes" detailLabel:@"Details Enclosed" icon:[UIImage imageNamed:@"advisory-notes"]],
                                                    [self infoCellWithIdentifier:@"YourPlaneInfoCell" topLabel:@"Your Plane" detailLabel:@"Cessna Citation Encore+" icon:[UIImage imageNamed:@"plane"]]
                                                    ]];
    
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : conditionalSectionsArray,
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
    } else if ([segue.identifier isEqualToString:@"showCrew"]) {
        NJOPCrewViewController *vc = [segue destinationViewController];
        vc.reservation = self.reservation;
    } else if ([segue.identifier isEqualToString:@"showPlane"]) {
        NJOPPlaneViewController *vc = [segue destinationViewController];
        vc.reservation = self.reservation;
    } else if ([segue.identifier isEqualToString:@"showAdvisoryNotes"]) {
        NJOPAdvisoryNotesController *vc = [segue destinationViewController];
        vc.reservation = self.reservation;
    }
}


- (IBAction)arrivalPinPressed:(id)sender {
    NSString *arrivalFBO = self.reservation.arrivalFboName;
    arrivalFBO = [arrivalFBO stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlString = @"http://maps.google.com/?q=";
    urlString = [urlString stringByAppendingString:arrivalFBO];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)departurePinPressed:(id)sender {
    
    NSString *departureFBO = self.reservation.departureFboName;
    departureFBO = [departureFBO stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlString = @"http://maps.google.com/?q=";
    urlString = [urlString stringByAppendingString:departureFBO];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}


- (void)testCoreDataFetch {
    
//    NJOPNetJetsCorePM *persistenceManager = [NJOPNetJetsCorePM sharedInstance];
//    NSArray *address = [NCLPersistenceUtil executeFetchRequestForEntityName:<#(NSString *)#> predicate:<#(NSPredicate *)#> context:<#(NSManagedObjectContext *)#> error:<#(NSError *__autoreleasing *)#>]
//    NSLog(@"%@", address);
    
}

@end
