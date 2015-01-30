// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPLocation.m instead.

#import "_NJOPLocation.h"

const struct NJOPLocationAttributes NJOPLocationAttributes = {
	.airportCity = @"airportCity",
	.airportID = @"airportID",
	.airportName = @"airportName",
	.fboID = @"fboID",
	.fboName = @"fboName",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.timeZone = @"timeZone",
};

const struct NJOPLocationRelationships NJOPLocationRelationships = {
	.arrivalLegs = @"arrivalLegs",
	.arrivalRequests = @"arrivalRequests",
	.departureLegs = @"departureLegs",
	.departureRequests = @"departureRequests",
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

@dynamic airportCity;

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

@dynamic latitude;

@dynamic longitude;

@dynamic timeZone;

@dynamic arrivalLegs;

- (NSMutableSet*)arrivalLegsSet {
	[self willAccessValueForKey:@"arrivalLegs"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"arrivalLegs"];

	[self didAccessValueForKey:@"arrivalLegs"];
	return result;
}

@dynamic arrivalRequests;

- (NSMutableSet*)arrivalRequestsSet {
	[self willAccessValueForKey:@"arrivalRequests"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"arrivalRequests"];

	[self didAccessValueForKey:@"arrivalRequests"];
	return result;
}

@dynamic departureLegs;

- (NSMutableSet*)departureLegsSet {
	[self willAccessValueForKey:@"departureLegs"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"departureLegs"];

	[self didAccessValueForKey:@"departureLegs"];
	return result;
}

@dynamic departureRequests;

- (NSMutableSet*)departureRequestsSet {
	[self willAccessValueForKey:@"departureRequests"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"departureRequests"];

	[self didAccessValueForKey:@"departureRequests"];
	return result;
}

@end

