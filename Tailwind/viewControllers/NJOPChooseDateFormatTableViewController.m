//
//  NJOPChooseDateFormatTableViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPChooseDateFormatTableViewController.h"
#import "NJOPSettingsManager.h"

@interface NJOPChooseDateFormatTableViewController ()

@end

@implementation NJOPChooseDateFormatTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	//
	self.cellTitles = @[[NSString stringWithFormat:@"US: %@",
						 [[[NJOPSettingsManager sharedInstance] dateFormatterForDateFormat:NJOPSettingsManagerDateFormatUS] stringFromDate:[NSDate date]]],
						[NSString stringWithFormat:@"EU: %@",
						 [[[NJOPSettingsManager sharedInstance] dateFormatterForDateFormat:NJOPSettingsManagerDateFormatEU] stringFromDate:[NSDate date]]]];
	
	//
	self.checkedInd = [NJOPSettingsManager sharedInstance].dateFormat;
	self.choiceOption = @"Date Format";
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[NJOPSettingsManager sharedInstance].dateFormat = (NJOPSettingsManagerDateFormat)indexPath.row;
	self.checkedInd = indexPath.row;
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.tableView reloadData];
}

@end
