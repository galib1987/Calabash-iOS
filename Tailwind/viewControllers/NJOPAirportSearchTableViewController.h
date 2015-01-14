//
//  NJOPAirportSearchTableViewController.h
//  Tailwind
//
//  Created by Angus.Lo on 1/14/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"

@interface NJOPAirportSearchTableViewController : SimpleDataSourceTableViewController

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

- (void)searchWith:(NSString*) term;

@end
