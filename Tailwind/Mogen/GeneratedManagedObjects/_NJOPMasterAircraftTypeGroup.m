// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPMasterAircraftTypeGroup.m instead.

#import "_NJOPMasterAircraftTypeGroup.h"

const struct NJOPMasterAircraftTypeGroupAttributes NJOPMasterAircraftTypeGroupAttributes = {
	.typeGroupNameForNJA = @"typeGroupNameForNJA",
	.typeGroupNameForNJE = @"typeGroupNameForNJE",
};

@implementation NJOPMasterAircraftTypeGroupID
@end

@implementation _NJOPMasterAircraftTypeGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MasterAircraftTypeGroup" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MasterAircraftTypeGroup";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MasterAircraftTypeGroup" inManagedObjectContext:moc_];
}

- (NJOPMasterAircraftTypeGroupID*)objectID {
	return (NJOPMasterAircraftTypeGroupID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic typeGroupNameForNJA;

@dynamic typeGroupNameForNJE;

@end

