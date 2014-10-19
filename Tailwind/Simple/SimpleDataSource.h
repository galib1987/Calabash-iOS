//
//  SimpleDataSource.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/13/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

@import Foundation;
@import UIKit;

extern NSString *const kSimpleDataSourceSectionCellsKey;
extern NSString *const kSimpleDataSourceSectionsTitleKey;
extern NSString *const kSimpleDataSourceCellIdentifierKey;
extern NSString *const kSimpleDataSourceSectionsHeaderIdentifierKey;
extern NSString	*const kSimpleDataSourceSectionsFooterIdentifierKey;
extern NSString *const kSimpleDataSourceSectionsHeaderKeyapthsKey;
extern NSString *const kSimpleDataSourceCellKeypaths;
extern NSString *const kSimpleDataSourceCellItem;
extern NSString *const kSimpleDataSourceCellSegueAction;

@interface SimpleDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, NSCoding>
@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) NSArray* headerFooterCellIdentifiers;
@property (nonatomic, copy) void (^didSelectBlock)(UIViewController*,NSIndexPath*);
@property (nonatomic, copy) void (^configureHeaderFooterViewBlock)(UIView*);
@property (nonatomic, copy) void (^configureTableCell)(UITableView*, UITableViewCell *,NSString*);

-(id)segueForIndexPath:(NSIndexPath*)indexPath;
-(id)itemForIndexPath:(NSIndexPath*)indexPath;
+(instancetype)dataSourceWithSections:(NSArray*)sections;

-(instancetype)initWithSections:(NSArray*)sections;

@property (nonatomic, strong) NSArray* sections;
@property (nonatomic, weak) UIViewController* controller;
-(void)loadData;

@end
