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

static NSDateFormatter *us_dateFormatter;
static NSDateFormatter *eu_dateFormatter;

+ (void)initialize
{
	us_dateFormatter = [[NSDateFormatter alloc] init];
	us_dateFormatter.dateFormat = @"EEEE MMM dd yyyy";
	eu_dateFormatter = [[NSDateFormatter alloc] init];
	eu_dateFormatter.dateFormat = @"EEEE dd MMM yyyy";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	//
	self.cellTitles = @[[NSString stringWithFormat:@"US: %@", [us_dateFormatter stringFromDate:[NSDate date]]],
						[NSString stringWithFormat:@"EU: %@", [eu_dateFormatter stringFromDate:[NSDate date]]]];
	
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
