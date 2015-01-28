//
//  NJOPChooseDistanceFormatTableViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPChooseDistanceFormatTableViewController.h"
#import "NJOPSettingsManager.h"

@interface NJOPChooseDistanceFormatTableViewController ()

@end

@implementation NJOPChooseDistanceFormatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.cellTitles = @[@"Miles", @"Kilometers"];
	
	//
	self.checkedInd = [NJOPSettingsManager sharedInstance].distanceFormat;
	self.choiceOption = @"Distance Format";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[NJOPSettingsManager sharedInstance].distanceFormat = (NJOPSettingsManagerDistanceFormat)indexPath.row;
	self.checkedInd = indexPath.row;
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.tableView reloadData];
}

@end
