//
//  FlightDetailViewController.h
//  Tailwind
//
//  Created by Amos Elmaliah on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"

@interface FlightDetailViewController : SimpleDataSourceTableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *shareButtonItem;
- (IBAction)shareAction:(id)sender;
@end
