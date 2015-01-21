//
//  NCOPersistenceManager.h
//  FliteDeck
//
//  Created by Chad Long on 3/13/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NCLPersistenceManager : NSObject

@property (nonatomic, readonly, strong) NSManagedObjectModel *objectModel;
@property (nonatomic, readonly, strong) NSManagedObjectContext *mainMOC;
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readonly, strong) NSString *sqliteFileNameBase;


- (NSString*)modelName;
- (BOOL)shouldAlwaysInstallResourcedDatabase;
- (BOOL)shouldBeExcludedFromBackup;
- (BOOL)supportsCustomModelMigration;

- (NSNumber*)storeSize;

- (void)updateDataForNewBundleVersion:(NSManagedObjectContext*)context;

- (NSManagedObjectContext*)privateMOC;
- (NSManagedObjectContext*)privateMOCWithParent:(NSManagedObjectContext*)parentMOC;

- (BOOL)save;

@end
