//
//  NJOPDisplayUnitsTableViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/26/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPDisplayUnitsTableViewController.h"

#import "NJOPSettingsManager.h"

@interface NJOPDisplayUnitsTableViewController ()

@property (nonatomic, weak) IBOutlet UITableViewCell *dateFormatCell;

@end

@implementation NJOPDisplayUnitsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.dateFormatCell.detailTextLabel.text = [NJOPSettingsManager sharedInstance].dateFormatDisplay;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
