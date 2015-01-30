//
//  NCOPersistenceManager.m
//  
//  Common persistence management
//
//  Created by Chad Long on 3/13/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import "NCLPersistenceManager.h"
#import <CoreData/CoreData.h>
#import "NCLFramework.h"
#import "NCLPrivateMOC.h"

@interface NCLPersistenceManager()

@property (nonatomic) BOOL migrationIsRequired;

@end

@implementation NCLPersistenceManager

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainMOC = _mainMOC;
@synthesize objectModel = _objectModel;

- (NSString*)modelName
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString*)sqliteFileNameBase
{
    return self.modelName;
}

- (BOOL)shouldAlwaysInstallResourcedDatabase
{
    return NO;
}

- (BOOL)shouldBeExcludedFromBackup
{
    return YES;
}

- (BOOL)supportsCustomModelMigration
{
    return NO;
}

- (void)updateDataForNewBundleVersion:(NSManagedObjectContext*)context
{
    // implementation provided by subclass if required
}

- (NSBundle*)mainBundle
{
    // may be overridden by test targets that contain their own sqlite DB (including the tests for this framework)
    return [NSBundle mainBundle];
}

- (BOOL)isFirstRunForBundleVersion
{
    NSString* lastBundleVersionKey = [NSString stringWithFormat:@"LastSQLiteBundleFor%@", [self sqliteFileNameBase]];
    
    NSString *bundleVersion = [[self mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    NSString *installedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:lastBundleVersionKey];

    if (installedVersion == nil ||
        ![bundleVersion isEqualToString:installedVersion])
    {
        DEBUGLog(@"detected new bundle version for model %@... %@", [self sqliteFileNameBase], bundleVersion);

        [[NSUserDefaults standardUserDefaults] setObject:bundleVersion forKey:lastBundleVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }

    return NO;
}

- (BOOL)isFirstRunForSQLiteDB:(NSURL*)resourcedStoreURL
{
    NSDate *sourcedFileDate = nil;
    NSDictionary *fileAttributes = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:resourcedStoreURL.path])
    {
        INFOLog(@"A data store is not resourced for model %@", self.modelName);
    }
    else
    {
        NSError *fileError = nil;
        fileAttributes = [fileManager attributesOfItemAtPath:resourcedStoreURL.path error:&fileError];
        
        if (fileError)
        {
            INFOLog(@"SQLite DB file access error: %@", [fileError localizedDescription]);
            @throw [NSException exceptionWithName:@"Database Access Error" reason:@"Error reading database version" userInfo:nil];
        }
        
        sourcedFileDate = [fileAttributes objectForKey:@"NSFileModificationDate"];
    }

    NSString* lastSQLiteDBKey = [NSString stringWithFormat:@"LastSQLiteDBFor%@", [self sqliteFileNameBase]];
    NSDate *installedFileDate = [[NSUserDefaults standardUserDefaults] objectForKey:lastSQLiteDBKey];
    
    if (sourcedFileDate != nil &&
        ![sourcedFileDate isEqualToDate:installedFileDate])
    {
        INFOLog(@"detected new data store for model %@... %@ --> %@", self.sqliteFileNameBase, sourcedFileDate, installedFileDate);
        
        [[NSUserDefaults standardUserDefaults] setObject:sourcedFileDate forKey:lastSQLiteDBKey];
        [[NSUserDefaults standardUserDefaults] synchronize];

        return YES;
    }
    
    return NO;
}

- (NSManagedObjectModel*)objectModel
{
	if (_objectModel)
		return _objectModel;
    
	NSBundle *bundle = [self mainBundle];
	NSString *modelPath = [bundle pathForResource:[self modelName] ofType:@"momd"];
    
    if (!modelPath)
    {
        modelPath = [bundle pathForResource:[NSString stringWithFormat:@"NCLFramework.framework/%@", [self modelName]] ofType:@"momd"];
        
        if (!modelPath)
        {
            INFOLog(@"missing resource for model: %@", [self modelName]);
            
            return nil;
        }
    }
    
	_objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];
    
	return _objectModel;
}

- (NSString*)storePath
{
    NSString *dbName = [[self sqliteFileNameBase] stringByAppendingString:@".sqlite"];
    
    return [[self sharedDocumentsPath] stringByAppendingPathComponent:dbName];
}

- (NSNumber*)storeSize
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbName = [[self sqliteFileNameBase] stringByAppendingString:@".sqlite"];
    NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:dbName];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:storePath error:NULL];
    
    if (fileAttributes)
        return [NSNumber numberWithLongLong:[fileAttributes fileSize] / 1024.0]; // expressed in KB
    else
        return @0;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
	if (_persistentStoreCoordinator)
		return _persistentStoreCoordinator;

    @synchronized(self)
    {
        if (_persistentStoreCoordinator)
            return _persistentStoreCoordinator;

        // output the data store location
        static dispatch_once_t storeLocation;
        
        dispatch_once(&storeLocation, ^{
            INFOLog(@"data store location is... %@", [self sharedDocumentsPath]);
        });
        
        // get the path to the data store
        NSURL *storeURL = [NSURL fileURLWithPath:[self storePath]];
        
        // instantiate the persistence store with a reference to the current model
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.objectModel];
        
        // get the metadata for the current store & check compatibility
        BOOL shouldUpdateLastKnownGood = NO;
        NSError *storeMetadataError = nil;
        BOOL storeIsCompatible = NO;
        NSDictionary *storeMetadata = nil;
        
        if (storeURL)
        {
            storeMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:storeURL error:&storeMetadataError];
            storeIsCompatible = [[_persistentStoreCoordinator managedObjectModel] isConfiguration:nil compatibleWithStoreMetadata:storeMetadata];
            shouldUpdateLastKnownGood = !storeIsCompatible;
            
            if (!storeIsCompatible &&
                [[NSFileManager defaultManager] fileExistsAtPath:[self storePath]])
            {
                INFOLog(@"persistent store is NOT compatible w/ the %@ model", self.modelName);
            }
        }
        
        // attempt a lightweight migration if needed (recheck compatibility if migrated successfully)
        if ([self doLightweightMigrationIfNeeded:storeURL metadata:storeMetadata isCompatible:storeIsCompatible])
        {
            storeMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:storeURL error:&storeMetadataError];
            storeIsCompatible = [[_persistentStoreCoordinator managedObjectModel] isConfiguration:nil compatibleWithStoreMetadata:storeMetadata];
        }

        // remove incompatible data stores & conditionally use resourced data stores
        [self processRequiredUpdatesForStoreWithURL:storeURL metadata:storeMetadata isCompatible:storeIsCompatible];

        // set the iCloud backup file attribute
        if (self.shouldBeExcludedFromBackup)
        {
            if ([storeURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:nil])
                DEBUGLog(@"resource is excluded from iCloud backup: %@", storeURL.description);
        }
        else
        {
            if ([storeURL setResourceValue:[NSNumber numberWithBool:NO] forKey:NSURLIsExcludedFromBackupKey error:nil])
                INFOLog(@"resource is INCLUDED in iCloud backup: %@", storeURL.description);
        }

        // create a "connection" to the database via the store coordinator
        NSError* error = nil;

        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                       configuration:nil
                                                                 URL:storeURL
                                                             options:@{NSSQLitePragmasOption:@{@"journal_mode" : @"DELETE"}}
                                                               error:&error])
        {
            INFOLog(@"fatal error creating or migrating persistent store: %@", error);
            
            abort();
        }
        
        // save the last known good model (helps with lightweight migrations)
        NSString *lastKnownGoodModelPath = [self lastKnownGoodModelPath];
        
        if (shouldUpdateLastKnownGood ||
            ![[NSFileManager defaultManager] fileExistsAtPath:lastKnownGoodModelPath])
        {
            NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:self.objectModel];
            [modelData writeToFile:lastKnownGoodModelPath atomically:YES];
            
            INFOLog(@"saved 'last known good' for the %@ model", self.sqliteFileNameBase);
        }

        return _persistentStoreCoordinator;
    }
}

- (BOOL)doLightweightMigrationIfNeeded:(NSURL*)storeURL metadata:(NSDictionary*)storeMetadata isCompatible:(BOOL)storeIsCompatible
{
    if (storeURL &&
        storeMetadata &&
        !storeIsCompatible)
    {
        // load the 'last known good' model
        NSString *objectModelPath = [self lastKnownGoodModelPath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:objectModelPath])
        {
            NSData *modelData = [NSData dataWithContentsOfFile:objectModelPath];
            NSManagedObjectModel *sourceModel = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
            
            // check to see if a lightweight migration is possible
            NSError *migrationError = nil;
            NSMappingModel *mappingModel = [NSMappingModel inferredMappingModelForSourceModel:sourceModel destinationModel:self.objectModel error:&migrationError];

            if (mappingModel)
            {
                // attempt the migration
                INFOLog(@"coredata will perform lightweight migration of the %@ model", [self sqliteFileNameBase]);

                NSError *migrationError = nil;
                NSMigrationManager *migrator = [[NSMigrationManager alloc] initWithSourceModel:sourceModel destinationModel:self.objectModel];
                
                NSString *storePath = [self storePath];
                NSString *oldStorePath = [NSString stringWithFormat:@"%@-old", storePath];
                
                DEBUGLog(@"oldStore:%@", oldStorePath);
                DEBUGLog(@"store:%@", storeURL);

                [[NSFileManager defaultManager] removeItemAtPath:oldStorePath error:nil];
                
                if ([[NSFileManager defaultManager] moveItemAtPath:storePath toPath:oldStorePath error:nil] &&
                    [migrator migrateStoreFromURL:[NSURL fileURLWithPath:oldStorePath]
                                             type:NSSQLiteStoreType
                                          options:@{NSSQLitePragmasOption:@{@"journal_mode" : @"DELETE"}}
                                 withMappingModel:mappingModel
                                 toDestinationURL:[NSURL fileURLWithPath:storePath]
                                  destinationType:NSSQLiteStoreType
                               destinationOptions:@{NSSQLitePragmasOption:@{@"journal_mode" : @"DELETE"}}
                                            error:&migrationError])
                {
                    NSError *deleteError = nil;
                    
                    if (![[NSFileManager defaultManager] removeItemAtPath:oldStorePath error:&deleteError])
                    {
                        INFOLog(@"WARNING: Unable to remove old %@ database: %@", [self sqliteFileNameBase], deleteError);
                    }
                    
                    INFOLog(@"migration SUCCESSFUL!");
                    
                    return YES;
                }
                else
                {
                    INFOLog(@"migration FAILED! - %@", migrationError);
                }
            }
            else
            {
                INFOLog(@"coredata cannot perform lightweight migration of the %@ model: %@", [self sqliteFileNameBase], migrationError);
            }
        }
        else
        {
            INFOLog(@"coredata cannot perform lightweight migration of the %@ model since 'last known good' model does not exist", [self sqliteFileNameBase]);
        }
    }
    
    return NO;
}

- (NSString*)lastKnownGoodModelPath
{
    return [[self sharedDocumentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"LastKnownGood%@Model", [self sqliteFileNameBase]]];
}

- (void)processRequiredUpdatesForStoreWithURL:(NSURL*)storeURL metadata:(NSDictionary*)storeMetadata isCompatible:(BOOL)storeIsCompatible
{
    // get the metadata for the resourced store (if one exists)
    BOOL isFirstRunForDB = NO;
    BOOL resourcedStoreIsCompatible = NO;
    NSURL *resourcedStoreURL = [[self mainBundle] URLForResource:[self sqliteFileNameBase] withExtension:@"sqlite"];
    
    if (resourcedStoreURL)
    {
        NSError *resourcedStoreMetadataError = nil;
        NSDictionary *resourcedStoreMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:resourcedStoreURL error:&resourcedStoreMetadataError];
        resourcedStoreIsCompatible = [[_persistentStoreCoordinator managedObjectModel] isConfiguration:nil compatibleWithStoreMetadata:resourcedStoreMetadata];
        
        if (!resourcedStoreIsCompatible)
            INFOLog(@"resourced data store is NOT compatible with model %@", [self modelName]);
        
        // determine if this is a new DB
        isFirstRunForDB = [self isFirstRunForSQLiteDB:resourcedStoreURL];
    }

    // remove the existing store when appropriate
    if (storeMetadata != nil)
    {
        // if the current store is not compatible with the current model and this instance of the PM does not support versioning, remove the current store
        if (![self supportsCustomModelMigration] &&
            !storeIsCompatible)
        {
            [self removeStoreAtURL:storeURL];
        }
        
        // if a compatible resourced store exists, and this instance of the PM is configured to always install "new" resourced stores, we need to first remove any existing stores
        else if (resourcedStoreIsCompatible &&
             [self shouldAlwaysInstallResourcedDatabase] &&
             isFirstRunForDB)
        {
            [self removeStoreAtURL:storeURL];
        }
    }

    // install the resourced store when appropriate
    if (resourcedStoreIsCompatible)
    {
        // if the resourced store is compatible with the current model & the current store doesn't exist, install the resourced store
        if (storeMetadata == nil)
        {
            [self installStoreAtURL:resourcedStoreURL toURL:storeURL];
        }
        
        // if a compatible resourced store exists, and this instance of the PM is configured to always install "new" resourced stores
        else if ([self shouldAlwaysInstallResourcedDatabase] &&
                 isFirstRunForDB)
        {
            [self installStoreAtURL:resourcedStoreURL toURL:storeURL];
        }
    }
}

- (void)removeStoreAtURL:(NSURL*)storeURL
{
    INFOLog(@"removing existing data store: %@", storeURL);
    
    NSError *fileError = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager removeItemAtURL:storeURL error:&fileError])
    {
        INFOLog(@"Fatal error removing existing data store: %@", fileError);
        [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"coreData" action:@"removeStoreAtURL" value:storeURL.description error:fileError]];
        
        abort();
    }
}

- (void)installStoreAtURL:(NSURL*)resourcedStoreURL toURL:(NSURL*)storeURL
{
    INFOLog(@"installing resourced sqlite file %@\nto %@...", resourcedStoreURL, storeURL);
    
    NSError *fileError = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager copyItemAtURL:resourcedStoreURL toURL:storeURL error:&fileError])
    {
        INFOLog(@"Fatal error copying new data store: %@", fileError);
        [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"coreData" action:@"installStoreAtURL" value:storeURL.description error:fileError]];
        
        abort();
    }
}

#pragma mark - Object contexts

- (NSManagedObjectContext*)mainMOC
{
	if (_mainMOC)
		return _mainMOC;
    
	// create the main context only on the main thread
	if (![NSThread isMainThread])
    {
		[self performSelectorOnMainThread:@selector(mainMOC)
                               withObject:nil
                            waitUntilDone:YES];
		return _mainMOC;
	}
    
    @synchronized(self)
    {
        if (_mainMOC)
            return _mainMOC;
        
        _mainMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_mainMOC setPersistentStoreCoordinator:self.persistentStoreCoordinator];
        
        // import static data if required
        if ([self isFirstRunForBundleVersion])
            [self updateDataForNewBundleVersion:_mainMOC];
    }
    
	return _mainMOC;
}

- (NSManagedObjectContext*)privateMOC
{
    if (![NSThread isMainThread])
    {
        return [self privateMOCWithParent:[self mainMOC]];
    }
    else
    {
        return [self mainMOC];
    }
}

- (NSManagedObjectContext*)privateMOCWithParent:(NSManagedObjectContext*)parentMOC
{
    NCLPrivateMOC *moc = [[NCLPrivateMOC alloc] initWithParentMOC:parentMOC];
    
    if (parentMOC == nil)
        [moc setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
	return moc;
}

#pragma mark - Save and merge

- (BOOL)save
{
	if (![self.mainMOC hasChanges])
		return YES;
    
    BOOL saveStatus = YES;
    NSError *error = nil;
    
    if (![self.mainMOC save:&error])
    {
        saveStatus = NO;
    }

    if (saveStatus == NO)
    {
        INFOLog(@"error saving to mainMOC: %@\n%@", [error localizedDescription], [error userInfo]);
        [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"coreData" action:@"save" value:NSStringFromClass([self class]) error:error]];
        
        [NCLFramework presentError:error];
    }
    else
    {
        INFOLog(@"save of mainMOC completed");
    }
    
	return saveStatus;
}

#pragma mark - DB location

- (NSString*)sharedDocumentsPath
{
	static NSString *SharedDocumentsPath = nil;
    
	if (SharedDocumentsPath)
		return SharedDocumentsPath;
    
	// compose a path to the <Library>/Database directory
	NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	SharedDocumentsPath = [libraryPath stringByAppendingPathComponent:@"Database"];
    
	// ensure the database directory exists
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL isDirectory;
    
	if (![fileManager fileExistsAtPath:SharedDocumentsPath isDirectory:&isDirectory] || !isDirectory)
    {
		NSError *error = nil;
		NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
		[fileManager createDirectoryAtPath:SharedDocumentsPath
               withIntermediateDirectories:YES
                                attributes:attr
                                     error:&error];
        
		if (error)
        {
			INFOLog(@"Error creating directory path for database: %@", [error localizedDescription]);
        }
	}
    
	return SharedDocumentsPath;
}

@end

