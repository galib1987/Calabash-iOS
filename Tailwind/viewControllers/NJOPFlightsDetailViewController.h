//
//  NJOPFlightsDetailViewController.h
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"
#import "NJOPReservation.h"
#import "AppDelegate.h"

@interface NJOPFlightsDetailViewController : SimpleDataSourceTableViewController

@property (strong, nonatomic) NJOPReservation *reservation;

@end
