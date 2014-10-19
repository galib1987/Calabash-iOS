//
//  SimpleDataSource.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/13/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "SimpleDataSource.h"

NSString* const kSimpleDataSourceSectionCellsKey = @"SectionCellsKey";
NSString* const kSimpleDataSourceSectionsTitleKey = @"SectionsTitleKey";
NSString* const kSimpleDataSourceSectionsHeaderIdentifierKey = @"SectionsHeaderIdentifierKey";
NSString* const kSimpleDataSourceSectionsFooterIdentifierKey = @"SectionsFooterIdentifierKey";
NSString* const kSimpleDataSourceSectionsHeaderKeyapthsKey = @"SectionsHeaderKeyapthsKey";

NSString* const kSimpleDataSourceCellIdentifierKey = @"CellIdentifierKey";
NSString* const kSimpleDataSourceCellKeypaths = @"CellKeypaths";
NSString* const kSimpleDataSourceCellItem = @"CellItem";
NSString* const kSimpleDataSourceCellSegueAction = @"CellSegueAction";

@interface SimpleDataSource ()
@property (nonatomic, strong) NSDictionary* segues;
@property (nonatomic) BOOL hasHeadersOfFooters;
@end

@implementation SimpleDataSource

#pragma mark -

-(BOOL)respondsToSelector:(SEL)aSelector {
	static SEL selector;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		selector = @selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:);
	});

	if (aSelector == selector) {
		return [self hasHeadersOfFooters];
	} else {
		return [super respondsToSelector:aSelector];
	}
}

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

-(BOOL)hasHeadersOfFootersForSections:(NSArray*)array {
	if (array && array.count) {
		for (id sectionInfo in array) {
			if (sectionInfo[kSimpleDataSourceSectionsHeaderIdentifierKey] ||
					sectionInfo[kSimpleDataSourceSectionsFooterIdentifierKey]) {
				return YES;
			}
		}
	}
	return NO;
}

-(void)setKeyPaths:(NSDictionary*)keypaths object:(id)object {

	[keypaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		NSError* validationError = nil;
		if ([object validateValue:&obj forKeyPath:key error:&validationError]) {
			[object setValue:obj forKeyPath:key];
		} else {
#if DEBUG
			[[NSException exceptionWithName:@"Invalid KVO"
															 reason:@"KVO Validation Failed for cell"
														 userInfo:nil] raise];
#else

#endif
		}
	}];
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
			self.hasHeadersOfFooters = [self hasHeadersOfFootersForSections:sections];
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
#pragma mark - Private

-(id)sectionInfoAtIndex:(NSInteger)sectionIndex {
	id sectionInfo = self.sections[sectionIndex];
	return sectionInfo;
}

#pragma mark - Table view Delegate


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

	NSDictionary* sectionInfo = [self sectionInfoAtIndex:section];
	NSString* identifier = sectionInfo[kSimpleDataSourceSectionsHeaderIdentifierKey];
	if (identifier) {
		UIView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
		NSAssert(headerView, @"expected a view to be registered");
		NSDictionary* keypaths = sectionInfo[kSimpleDataSourceSectionsHeaderKeyapthsKey];
		[self setKeyPaths:keypaths object:headerView];
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
	id sectionInfo = [self sectionInfoAtIndex:section];
	NSString *title = sectionInfo[kSimpleDataSourceSectionsTitleKey];
	return title;
}

#pragma mark UITable View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger sections = self.sections ? self.sections.count : 0;
	return sections;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id sectionInfo = [self sectionInfoAtIndex:section];
	NSArray* cells = sectionInfo[kSimpleDataSourceSectionCellsKey];
	return cells ? cells.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	id sectionInfo = [self sectionInfoAtIndex:indexPath.section];
	NSArray* cells = sectionInfo[kSimpleDataSourceSectionCellsKey];
	NSAssert([cells isKindOfClass:[NSArray class]], @"sanity check failed, expected an arraygot something else");
	NSDictionary* cellData = cells ? cells[indexPath.row] : nil;

	NSString* identifier = cellData[kSimpleDataSourceCellIdentifierKey];
	NSAssert(identifier, @"nil identifier missing");
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
																													forIndexPath:indexPath];
	NSAssert(cells, @"table view wasn't able to dequeue cell");
	NSDictionary* keypaths = cellData[kSimpleDataSourceCellKeypaths];

	[self setKeyPaths:keypaths object:cell];

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
	id sectionInfo = [self sectionInfoAtIndex:section];
	NSArray* cells = sectionInfo[kSimpleDataSourceSectionCellsKey];
	return cells ? cells.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	id sectionInfo = [self sectionInfoAtIndex:indexPath.section];
	NSArray* cells = sectionInfo[kSimpleDataSourceSectionCellsKey];
	NSAssert([cells isKindOfClass:[NSArray class]], @"sanity check failed, expected an arraygot something else");
	NSDictionary* cellData = cells ? cells[indexPath.row] : nil;
	NSAssert(cellData, @"nil cell info");
	NSString* identifier = cellData[kSimpleDataSourceCellIdentifierKey];
	NSAssert(identifier, @"nil identifier missing");
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
																																				 forIndexPath:indexPath];
	NSAssert(cell, @"collection view wasn't able to dequeue cell");
	[cell aapl_Xcode6OniOS7hotfix];

	NSDictionary* keypaths = cellData[kSimpleDataSourceCellKeypaths];

	[self setKeyPaths:keypaths object:cell];

 return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

	id sectionInfo = [self sectionInfoAtIndex:indexPath.section];
	NSString* identifier;
	if (kind == UICollectionElementKindSectionHeader) {
		identifier = sectionInfo[kSimpleDataSourceSectionsHeaderIdentifierKey] ? : @"Header";
	} else if(kind == UICollectionElementKindSectionFooter) {
		identifier = sectionInfo[kSimpleDataSourceSectionsFooterIdentifierKey] ? : @"Footer";
	} else {
#if DEBUG
		[[NSException exceptionWithName:@"Invalid Supplementary Element Kind"
															reason:@"Not supporting this CollectionView Supplementary Element Kind "
														userInfo:nil] raise];
#endif
		identifier = @"placeholder";
	}

	UICollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
																																			withReuseIdentifier:identifier
																																						 forIndexPath:indexPath];

	NSDictionary* keypaths;
	if (kind == UICollectionElementKindSectionHeader) {
		keypaths = sectionInfo[kSimpleDataSourceSectionsHeaderKeyapthsKey];
	} else if(kind == UICollectionElementKindSectionFooter) {
		keypaths = sectionInfo[kSimpleDataSourceSectionsFooterIdentifierKey];
	}

	if (keypaths) {
		[self setKeyPaths:keypaths object:view];
	}

	return view;
}

@end
