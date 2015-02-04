//
//  NJOPHomeViewController.h
//  Tailwind
//
//  Created by netjets on 12/18/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleDataSourceTableViewController.h"

@interface NJOPHomeViewController : SimpleDataSourceTableViewController

@property (nonatomic, retain) UIView *coverView;

-(void)updateWithReservations:(NSArray*)reservations; // get the data for the person and update the view

@end
