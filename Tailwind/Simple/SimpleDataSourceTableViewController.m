//
//  SimpleDataSourceTableViewController.m
//  Tailwind
//
//  Created by NetJets on 10/12/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"
#import "UIColor+NJOP.h"

@interface SimpleDataSourceTableViewController ()
@property (nonatomic, strong) NSArray* sections;
@end

@implementation SimpleDataSourceTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.tableView setBackgroundColor:SCROLLVIEW_BACKGORUND_COLOR];
	self.tableView.estimatedRowHeight = 44.0;
	self.tableView.rowHeight = UITableViewAutomaticDimension;

	[self loadDataSource];
	[self registerReusableViews];
	self.title = self.dataSource.title ? : self.title;
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
}

#pragma mark - Subclass

-(void)loadDataSource {
	
}

-(void)registerReusableViews {

}

#pragma mark - Table view DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource numberOfSectionsInTableView:tableView];
	};
	return 0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource tableView:tableView numberOfRowsInSection:section];
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
	}
	return nil;
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

-(NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	return indexPath;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString* segue = nil;
	if ([self.dataSource respondsToSelector:@selector(segueForCellAtIndexPath:)] &&
			(segue = [self.dataSource segueForCellAtIndexPath:indexPath])) {
		
		[self performSegueWithIdentifier:segue sender:self];

	}
	else if (self.dataSource.didSelectBlock) {

		self.dataSource.didSelectBlock(self, indexPath);
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
