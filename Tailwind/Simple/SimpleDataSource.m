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
NSString* const kSimpleDataSourceCellItem = @"CellItem";
NSString* const kSimpleDataSourceCellSegueAction = @"CellSegueAction";

@interface SimpleDataSource ()
@property (nonatomic, strong) NSDictionary* segues;
@end
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

#pragma mark - Private 

-(NSDictionary*)seguesFromSections:(NSArray*)sections {

	__block NSMutableDictionary* mutable = nil;
	[sections enumerateObjectsUsingBlock:^(NSDictionary* section, NSUInteger sectionIndex, BOOL *stop) {
		[section[kSimpleDataSourceSectionCellsKey] enumerateObjectsUsingBlock:^(NSDictionary* cell, NSUInteger itemIndex, BOOL *stop) {
			NSString* segueName = cell[kSimpleDataSourceCellSegueAction];
			if (segueName) {
				if (!mutable) {
					mutable = [NSMutableDictionary new];
				}
				mutable[[NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex]] = segueName;
			}
		}];
	}];

	return mutable.copy;
}

#pragma mark - Accessors 

-(void)setSections:(NSArray *)sections {
	if (![_sections isEqual:sections]) {
		if (_sections) {
			// remove all dependencies:
			self.segues = nil;
		}
		_sections = sections;
		if (_sections) {
			self.segues = [self seguesFromSections:_sections];
		}
	}
}

#pragma mark - PUblic

-(void)loadData {

}

-(id)itemForIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.item) {
		return self.sections[indexPath.section][kSimpleDataSourceSectionCellsKey][indexPath.item][kSimpleDataSourceCellItem];
	}
	// no support for section item yet.
	return nil;
}

-(id)segueForIndexPath:(NSIndexPath *)indexPath {
	return self.segues ? self.segues[indexPath] : nil;
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

	if (self.configureTableCell) {
		self.configureTableCell(tableView, cell, identifier);
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
