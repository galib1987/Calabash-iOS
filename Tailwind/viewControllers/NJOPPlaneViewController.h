//
//  NJOPPlaneViewController.h
//  Tailwind
//
//  Created by netjets on 1/19/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"
#import "NJOPReservation.h"

@interface NJOPPlaneViewController : SimpleDataSourceTableViewController

@property (nonatomic) NJOPReservation *reservation;

@end
