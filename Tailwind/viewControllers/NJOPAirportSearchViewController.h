//
//  NJOPAirportSearchViewController.h
//  Tailwind
//
//  Created by Angus.Lo on 1/12/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPAirportSearchTableViewController.h"

@interface NJOPAirportSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchInput;
@property (weak, nonatomic) IBOutlet UILabel *resultsSectionTitle;
@property (nonatomic) BOOL editingDeparture;

@property (strong, nonatomic) NJOPAirportSearchTableViewController *resultsTable;
@property (weak, nonatomic) IBOutlet UIView *resultsPlaceholder;

@end
