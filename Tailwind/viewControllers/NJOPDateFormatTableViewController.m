//
//  NJOPDateFormatTableViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/26/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPDateFormatTableViewController.h"

#import "NJOPSettingsManager.h"

@interface NJOPDateFormatTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *usDateFormatCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *euDateFormatCell;

@end

@implementation NJOPDateFormatTableViewController

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
	
	[self updateUIBasedOnSettings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	[NJOPSettingsManager sharedInstance].dateFormat = (NJOPSettingsManagerDateFormat)indexPath.row;
	[self updateUIBasedOnSettings];
}

#pragma mark - private

- (void)updateUIBasedOnSettings {
	
	//
	switch ([NJOPSettingsManager sharedInstance].dateFormat) {
		case NJOPSettingsManagerDateFormatUS:
		{
			self.usDateFormatCell.detailTextLabel.text = @"\u2713";
			self.euDateFormatCell.detailTextLabel.text = nil;
		}
			break;
			
		case NJOPSettingsManagerDateFormatEU:
		{
			self.euDateFormatCell.detailTextLabel.text = @"\u2713";
			self.usDateFormatCell.detailTextLabel.text = nil;
		}
			break;
			
		default:
			break;
	}
}

@end
