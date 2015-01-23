// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPMasterAircraftType.m instead.

#import "_NJOPMasterAircraftType.h"

const struct NJOPMasterAircraftTypeAttributes NJOPMasterAircraftTypeAttributes = {
	.cabinSizeForNJA = @"cabinSizeForNJA",
	.cabinSizeForNJE = @"cabinSizeForNJE",
	.typeGroupNameForNJA = @"typeGroupNameForNJA",
	.typeGroupNameForNJE = @"typeGroupNameForNJE",
};

@implementation NJOPMasterAircraftTypeID
@end

@implementation _NJOPMasterAircraftType

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MasterAircraftType" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MasterAircraftType";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MasterAircraftType" inManagedObjectContext:moc_];
}

- (NJOPMasterAircraftTypeID*)objectID {
	return (NJOPMasterAircraftTypeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic cabinSizeForNJA;

@dynamic cabinSizeForNJE;

@dynamic typeGroupNameForNJA;

@dynamic typeGroupNameForNJE;

@end

