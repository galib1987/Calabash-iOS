//
//  NJOPDetailViewController.m
//  Tailwind
//
//  Created by netjets on 1/29/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPDetailViewController.h"
#import "NJOPClient+flights.h"
#import "NJOPPassengeManifestViewController.h"
#import "NJOPGroundViewController.h"
#import "NJOPCateringViewController.h"
#import "NJOPCrewViewController.h"
#import "NJOPPlaneViewController.h"
#import "NJOPIntrospector.h"
#import "NJOPAdvisoryNotesController.h"
#import "NJOPTitleSummaryViewController.h"
#import "NJOPNetJetsCorePM.h"
#import <NCLPersistenceUtil.h>
#import "NJOPTailwindPM.h"
#import "NJOPDropdownView.h"
#import "NJOPDropdownRequestView.h"

@interface NJOPDetailViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic) SimpleDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NJOPDropdownView *reservationDropdownView;
@property (weak, nonatomic) IBOutlet NJOPDropdownRequestView *requestDropdownView;
@property (nonatomic) CGFloat affixedY;

@end

@implementation NJOPDetailViewController

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
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.scrollView.delegate = self;
    
    [self.tableView setBackgroundColor:SCROLLVIEW_BACKGORUND_COLOR];
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.scrollEnabled = NO;
    self.tableView.scrollsToTop = NO;
    
    for (UIView *view in self.view.subviews) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = contentRect.size;
    
    [self loadDataSource];
    [self registerReusableViews];
    [self updateDropdownLabels];
    
    self.title = self.dataSource.title ? : self.title;
    NSArray* headerFooters = [self.dataSource headerFooterCellIdentifiers];
    if (headerFooters && headerFooters.count) {
        for (NSString* identifier in headerFooters) {
            UINib* nib = [UINib nibWithNibName:identifier bundle:nil];
            if (nib) {
                [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
            }
        }
    }
    
    if (self.dataSource.configureHeaderFooterViewBlock) {
        UIView* view = self.tableView.tableHeaderView;
        if (view) {
            self.dataSource.configureHeaderFooterViewBlock(view);
        }
        view = self.tableView.tableFooterView;
        if (view) {
            self.dataSource.configureHeaderFooterViewBlock(view);
        }
    }
}


- (void)updateDropdownLabels {
    NJOPTailwindPM *persistenceManager = [NJOPTailwindPM sharedInstance];
    NJOPReservation2 *reservation = [persistenceManager reservationForID:self.reservation.reservationId createIfNeeded:NO moc:persistenceManager.mainMOC];
    NSLog(@"%@", reservation.reservationID); // reservation id
    self.affixedY = self.reservationDropdownView.frame.size.height;
    self.reservationDropdownView.reservationIdLabel.text = [NSString stringWithFormat:@"Reservation: %@", reservation.reservationID];
    
    NSArray* requestsForReservation = [reservation.requests allObjects];
    NSLog(@"%lu", (unsigned long)[requestsForReservation count]); // how many requests
    
    self.reservationDropdownView.ofRequestsLabel.text = [NSString stringWithFormat:@"1 of %lu Requests", (unsigned long)[requestsForReservation count]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EE MMM dd, YYYY"];
    
    
//    for (NJOPRequest2 *request in requestsForReservation) {
//        
//        NJOPDropdownRequestView *requestView = [[NJOPDropdownRequestView alloc] init];
//        requestView.backgroundColor = [UIColor blackColor];
//        requestView.requestIdLabel.text = [NSString stringWithFormat:@"Request: %@", request.requestID];
//        requestView.dateLabel.text = [formatter stringFromDate:request.depTime];
//        requestView.airportLabel.text = @"HERE - THERE";
//        self.affixedY = self.affixedY + requestView.frame.size.height;
//        [self.view addSubview:requestView];
//        NSArray *legsArray = [request.legs allObjects];
//        for (NJOPLeg *leg in legsArray) {
//            NSLog(@"%@ %@ %@", [formatter stringFromDate:leg.depTime], leg.depLocation.airportName, leg.arrLocation.airportName);
//            
//        }
//    }
}

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    CGFloat scrollViewHeight = 0.0f;
//    CGFloat scrollViewWidth = 0.0f;
//    
//    for (UIView *view in self.scrollView.subviews) {
//        CGFloat height = view.frame.size.height + view.frame.origin.y;
//        scrollViewHeight = ((height > scrollViewHeight) ? height : scrollViewHeight);
//        
//        CGFloat width = view.frame.size.width + view.frame.origin.x;
//        scrollViewWidth = ((width > scrollViewWidth) ? width : scrollViewWidth);
//        
//    }
//    
//    [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, scrollViewHeight)];
//}

#pragma mark - Subclass

-(void)loadDataSource {
    
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

-(void)registerReusableViews {
    
}

#pragma mark - Table view DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:_cmd]) {
        return [self.dataSource numberOfSectionsInTableView:tableView];
    };
    return 0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:_cmd]) {
        return [self.dataSource tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:_cmd]) {
        return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - Table view Delegate

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([self.dataSource respondsToSelector:_cmd]) {
        return [self.dataSource tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:_cmd]) {
        return [self.dataSource tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:_cmd]) {
        return [self.dataSource tableView:tableView estimatedHeightForHeaderInSection:section];
    }
    return 44.0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:_cmd]) {
        return [self.dataSource tableView:tableView titleForHeaderInSection:section];
    }
    return nil;
}

-(NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* segue = nil;
    if ([self.dataSource respondsToSelector:@selector(segueForCellAtIndexPath:)] &&
        (segue = [self.dataSource segueForCellAtIndexPath:indexPath])) {
        
        [self performSegueWithIdentifier:segue sender:self];
        
    }
    else if (self.dataSource.didSelectBlock) {
        
        self.dataSource.didSelectBlock(self, indexPath);
    }
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

@end
