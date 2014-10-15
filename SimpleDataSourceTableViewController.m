//
//  SimpleDataSourceTableViewController.m
//  HTabDemo
//
//  Created by Amos Elmaliah on 10/12/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"

@interface SimpleDataSourceTableViewController ()
@property (nonatomic, strong) NSArray* sections;
@end

@implementation SimpleDataSourceTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.estimatedRowHeight = 44.0;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	[self.navigationController  setNavigationBarHidden:YES];

	[self loadDataSource];
	[self registerReusableViews];
	
	NSArray* headerFooters = [self.dataSource headerFooterCellIdentifiers];
	if (headerFooters && headerFooters.count) {
		for (NSString* identifier in headerFooters) {
			UINib* nib = [UINib nibWithNibName:identifier bundle:nil];
			if (nib) {
				[self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
			}
		}
	}

	if (self.dataSource.configureHeaderFooterViewBlock) {
		UIView* view = self.tableView.tableHeaderView;
		if (view) {
			self.dataSource.configureHeaderFooterViewBlock(view);
		}
		view = self.tableView.tableFooterView;
		if (view) {
			self.dataSource.configureHeaderFooterViewBlock(view);
		}
	}

	if (!self.tableView.dataSource || self.tableView.dataSource == self) {
		self.tableView.dataSource = self.dataSource;
	}
}

-(void)loadDataSource {
	
}

-(void)registerReusableViews {

}

#pragma mark - Table view Delegate


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource tableView:tableView viewForHeaderInSection:section];
	}
	return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource tableView:tableView heightForHeaderInSection:section];
	}
	return 0;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource tableView:tableView estimatedHeightForHeaderInSection:section];
	}
	return 44.0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource tableView:tableView titleForHeaderInSection:section];
	}
	return nil;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.dataSource.onSelectBlock) {
		self.dataSource.onSelectBlock(self, indexPath);
	}
}

@end