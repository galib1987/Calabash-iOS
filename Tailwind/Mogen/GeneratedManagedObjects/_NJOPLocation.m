// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPLocation.m instead.

#import "_NJOPLocation.h"

const struct NJOPLocationAttributes NJOPLocationAttributes = {
	.airportID = @"airportID",
	.airportName = @"airportName",
	.fboID = @"fboID",
	.fboName = @"fboName",
	.timeZone = @"timeZone",
};

const struct NJOPLocationRelationships NJOPLocationRelationships = {
	.arrivalLegs = @"arrivalLegs",
	.departureLegs = @"departureLegs",
};

@implementation NJOPLocationID
@end

@implementation _NJOPLocation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Location";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Location" inManagedObjectContext:moc_];
}

- (NJOPLocationID*)objectID {
	return (NJOPLocationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"fboIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fboID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic airportID;

@dynamic airportName;

@dynamic fboID;

- (int32_t)fboIDValue {
	NSNumber *result = [self fboID];
	return [result intValue];
}

- (void)setFboIDValue:(int32_t)value_ {
	[self setFboID:@(value_)];
}

- (int32_t)primitiveFboIDValue {
	NSNumber *result = [self primitiveFboID];
	return [result intValue];
}

- (void)setPrimitiveFboIDValue:(int32_t)value_ {
	[self setPrimitiveFboID:@(value_)];
}

@dynamic fboName;

@dynamic timeZone;

@dynamic arrivalLegs;

- (NSMutableSet*)arrivalLegsSet {
	[self willAccessValueForKey:@"arrivalLegs"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"arrivalLegs"];

	[self didAccessValueForKey:@"arrivalLegs"];
	return result;
}

@dynamic departureLegs;

- (NSMutableSet*)departureLegsSet {
	[self willAccessValueForKey:@"departureLegs"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"departureLegs"];

	[self didAccessValueForKey:@"departureLegs"];
	return result;
}

@end

