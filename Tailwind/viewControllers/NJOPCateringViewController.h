//
//  NJOPCateringViewController.h
//  Tailwind
//
//  Created by netjets on 1/6/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"
#import "NJOPReservation.h"

@interface NJOPCateringViewController : SimpleDataSourceTableViewController

@property (strong, nonatomic) NJOPReservation *reservation;

@end
