//
//  NJOPChooseTemperatureFormatTableViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPChooseTemperatureFormatTableViewController.h"
#import "NJOPSettingsManager.h"

@interface NJOPChooseTemperatureFormatTableViewController ()

@end

@implementation NJOPChooseTemperatureFormatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.cellTitles = @[@"˚F", @"˚C"];
	
	//
	self.checkedInd = [NJOPSettingsManager sharedInstance].temperatureFormat;
	self.choiceOption = @"Temperature Format";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[NJOPSettingsManager sharedInstance].temperatureFormat = (NJOPSettingsManagerTemperatureFormat)indexPath.row;
	self.checkedInd = indexPath.row;
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.tableView reloadData];
}

@end
