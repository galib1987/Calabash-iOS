//
//  SimpleDataSource.m
//  HTabDemo
//
//  Created by Amos Elmaliah on 10/13/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "SimpleDataSource.h"

NSString* const kSimpleDataSourceSectionCellsKey = @"SectionCellsKey";
NSString* const kSimpleDataSourceSectionsTitleKey = @"SectionsTitleKey";
NSString* const kSimpleDataSourceSectionsHeaderIdentifierKey = @"SectionsHeaderIdentifierKey";
NSString* const kSimpleDataSourceSectionsHeaderKeyapthsKey = @"SectionsHeaderKeyapthsKey";
NSString* const kSimpleDataSourceSectionsHeaderKey = @"SectionHeaderIdentifier";

NSString* const kSimpleDataSourceCellIdentifierKey = @"CellIdentifierKey";
NSString* const kSimpleDataSourceCellKeypaths = @"CellKeypaths";
NSString* const kSimpleDataSourceCellSegueAction = @"CellSegueAction";

@implementation SimpleDataSource

#pragma mark Designated initializer

+(instancetype)dataSourceWithSections:(NSArray *)sections {
	return [[self alloc] initWithSections:sections];
}

-(instancetype)initWithSections:(NSArray *)sections {
	self = [super init];
	if (self) {
		self.sections = sections;
	}
	return self;
}

#pragma mark - NSObject

-(instancetype)init {
	self = [super init];
	if (self) {
		[self loadData];
	}
	return self;
}

#pragma mark NSCoding

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		[self loadData];
	}
	return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {

}

#pragma mark - PUblic

-(void)loadData {

}

#pragma mark - Table view Delegate


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

	NSDictionary* sectionObj = self.sections[section];
	NSString* identifier = sectionObj[kSimpleDataSourceSectionsHeaderIdentifierKey];
	if (identifier) {
		UIView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
		NSAssert(headerView, @"expected a view to be registered");
		NSDictionary* keypaths = sectionObj[kSimpleDataSourceSectionsHeaderKeyapthsKey];
		[keypaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
			[headerView setValue:obj forKeyPath:key];
		}];
		return headerView;
	}
	return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
	return 44.0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *title = self.sections[section][kSimpleDataSourceSectionsTitleKey];
	return title;
}

-(void (^)(UIViewController *, NSIndexPath *))onSelectBlock {
	return ^(UIViewController *vc, NSIndexPath *indexPath) {
		NSString* action = self.sections[indexPath.section][kSimpleDataSourceSectionCellsKey][indexPath.row][kSimpleDataSourceCellSegueAction];
		if (action) {
			[vc performSegueWithIdentifier:action sender:self];
		}
	};
}

#pragma mark UITable View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger sections = self.sections ? self.sections.count : 0;
	return sections;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.sections[section][kSimpleDataSourceSectionCellsKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary* cellData = self.sections[indexPath.section][kSimpleDataSourceSectionCellsKey][indexPath.row];

	NSString* identifier = cellData[kSimpleDataSourceCellIdentifierKey];
	NSAssert(identifier, @"nil identifier");
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
																													forIndexPath:indexPath];
	NSDictionary* keypaths = cellData[kSimpleDataSourceCellKeypaths];

	[keypaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[cell setValue:obj forKeyPath:key];
	}];

	if (self.configureCell) {
		self.configureCell(tableView, cell, identifier);
	}

 return cell;
}


#pragma mark UICollection view DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	NSInteger sections = self.sections ? self.sections.count : 0;
	return sections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.sections[section][kSimpleDataSourceSectionCellsKey] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary* cellData = self.sections[indexPath.section][kSimpleDataSourceSectionCellsKey][indexPath.row];

	NSString* identifier = cellData[kSimpleDataSourceCellIdentifierKey];
	NSAssert(identifier, @"nil identifier");
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
																																				 forIndexPath:indexPath];

	NSDictionary* keypaths = cellData[kSimpleDataSourceCellKeypaths];

	[keypaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[cell setValue:obj forKeyPath:key];
	}];
	
 return cell;
}

@end
