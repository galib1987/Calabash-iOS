//
//  NJOPGroundViewController.m
//  Tailwind
//
//  Created by netjets on 1/6/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPGroundViewController.h"
#import <DateTools/NSDate+DateTools.h>

@interface NJOPGroundViewController ()

@end

@implementation NJOPGroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)formatDateString:(NSDate *)date forDate:(BOOL)forDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (forDate == YES) {
        [formatter setDateFormat:@"EEEE MMM dd, YYYY"];
    } else {
        [formatter setDateFormat:@"hh:mm a"];
    }
    
    return [formatter stringFromDate:date];
    
}

- (NSString *)parseAndFormatRoute:(NSArray *)routeDescriptions {
    
    NSMutableString *routeString = [[NSMutableString alloc] init];
    
    for (NSString *desc in routeDescriptions) {
        [routeString appendString:[NSString stringWithFormat:@"%@ \n", desc]];
    }
    
    return routeString;
}

- (NSString *)parseAndFormatPassengers:(NSArray *)passengerRepresentations {
    NSMutableString *manifestString = [[NSMutableString alloc] init];
    
    for (NSDictionary *passengerRepresentation in passengerRepresentations) {
        NSString *currentPassengerName = passengerRepresentation[@"passengerName"];
        [manifestString appendString:[NSString stringWithFormat:@"%@ \n", currentPassengerName]];
    }
    
    NSLog(@"%@", manifestString);
    return manifestString;
}

- (NSDictionary *)createDepartureCellFromReservation:(NSDictionary *)departureGroundOrder {
    
    NSDictionary *cellRepresentation = @{
                                         kSimpleDataSourceCellIdentifierKey			: @"NJOPGroundCellDeparture",
                                         kSimpleDataSourceCellKeypaths					: @{
                                                 @"topLabel.text" : @"DEPARTURE",
                                                 @"groundTypeLabel.text" : [NSString stringWithFormat:@"Vehicle #1 - %@", departureGroundOrder[@"groundType"]],
                                                 @"autoSizeLabel.text" : departureGroundOrder[@"autoSize"],
                                                 @"carServiceLabel.text" : departureGroundOrder[@"vendorName"],
                                                 @"pickupTimeLabel.text" : [self formatDateString:_reservation.departureDate forDate:NO],
                                                 @"pickupDateLabel.text" : [self formatDateString:_reservation.departureDate forDate:YES],
                                                 @"routeDescLabel.text" : [self parseAndFormatRoute:departureGroundOrder[@"routeDescriptions"]],
                                                 @"passengers.text" : [self parseAndFormatPassengers:self.reservation.passengers],
                                                 }
                                         };
    
    return cellRepresentation;
    
}


- (NSDictionary *)createArrivalCellFromReservation:(NSDictionary *)arrivalGroundOrder {
    
    NSDictionary *cellRepresentation = @{
                                         kSimpleDataSourceCellIdentifierKey			: @"NJOPGroundCellArrival",
                                         kSimpleDataSourceCellKeypaths					: @{
                                                 @"topLabel.text" : @"ARRIVAL",
                                                 @"groundTypeLabel.text" : [NSString stringWithFormat:@"Vehicle #1 - %@", arrivalGroundOrder[@"groundType"]],
                                                 @"autoSizeLabel.text" : arrivalGroundOrder[@"autoSize"],
                                                 @"carServiceLabel.text" : arrivalGroundOrder[@"vendorName"],
                                                 @"pickupTimeLabel.text" : [self formatDateString:_reservation.arrivalDate forDate:NO],
                                                 @"pickupDateLabel.text" : [self formatDateString:_reservation.arrivalDate forDate:YES],
                                                 @"routeDescLabel.text" : [self parseAndFormatRoute:arrivalGroundOrder[@"routeDescriptions"]],
                                                 @"passengers.text" : [self parseAndFormatPassengers:self.reservation.passengers],
                                                 }
                                         };
    
    return cellRepresentation;
    
}

- (void)loadDataSource {

    NSDictionary *departureGroundOrder = _reservation.groundOrders[0];
    NSDictionary *arrivalGroundOrder = _reservation.groundOrders[1];
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      [self createArrivalCellFromReservation:departureGroundOrder],
                                      [self createDepartureCellFromReservation:arrivalGroundOrder]
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"GROUND";
}


@end
