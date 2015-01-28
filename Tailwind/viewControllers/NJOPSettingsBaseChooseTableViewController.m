//
//  NJOPSettingsBaseChooseTableViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPSettingsBaseChooseTableViewController.h"

#import "NJOPChooseTableViewHeader.h"
#import "NJOPChooseTableViewCell.h"

@implementation NJOPSettingsBaseChooseTableViewController

#pragma mark - UITableViewDataSource

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.backgroundColor = [UIColor clearColor];
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	[self.tableView registerNib:[UINib nibWithNibName:@"NJOPChooseTableViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"headerId"];
	[self.tableView registerNib:[UINib nibWithNibName:@"NJOPChooseTableViewCell" bundle:nil] forCellReuseIdentifier:@"choiceCell"];
	self.tableView.scrollEnabled = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.cellTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NJOPChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"choiceCell"];
	
	cell.choiceTitle = (NSString *)self.cellTitles[indexPath.row];
	cell.checked = (self.checkedInd == indexPath.row);

	return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NJOPChooseTableViewHeader *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerId"];

	headerView.choiceOption = self.choiceOption;
	
	return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 84;
}

@end
