//
//  ReservationDetailViewController.h
//  Tailwind
//
//  Created by NetJets on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"

@interface ReservationDetailViewController : SimpleDataSourceTableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *shareButtonItem;
- (IBAction)shareAction:(id)sender;
@end
