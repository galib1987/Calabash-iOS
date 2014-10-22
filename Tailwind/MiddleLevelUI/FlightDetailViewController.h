//
//  FlightDetailViewController.h
//  Tailwind
//
//  Created by Amos Elmaliah on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITableViewSectionedDataSource <NSObject>
@end

@interface FlightDetailViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *shareButtonItem;
- (IBAction)shareAction:(id)sender;
@end
