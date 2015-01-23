// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPAircraftSpecMatrix.m instead.

#import "_NJOPAircraftSpecMatrix.h"

const struct NJOPAircraftSpecMatrixAttributes NJOPAircraftSpecMatrixAttributes = {
	.highSpeedDistanceInKPHForNJA = @"highSpeedDistanceInKPHForNJA",
	.highSpeedDistanceInKPHForNJE = @"highSpeedDistanceInKPHForNJE",
	.highSpeedDistanceInMPHForNJA = @"highSpeedDistanceInMPHForNJA",
	.highSpeedDistanceInMPHForNJE = @"highSpeedDistanceInMPHForNJE",
	.longRangeDistanceInKPHForNJA = @"longRangeDistanceInKPHForNJA",
	.longRangeDistanceInKPHForNJE = @"longRangeDistanceInKPHForNJE",
	.longRangeDistanceInMPHForNJA = @"longRangeDistanceInMPHForNJA",
	.longRangeDistanceInMPHForNJE = @"longRangeDistanceInMPHForNJE",
	.passengerCount = @"passengerCount",
	.rangeInHours = @"rangeInHours",
	.rangeMapDistanceInKPHForNJA = @"rangeMapDistanceInKPHForNJA",
	.rangeMapDistanceInKPHForNJE = @"rangeMapDistanceInKPHForNJE",
	.typeName = @"typeName",
};

const struct NJOPAircraftSpecMatrixRelationships NJOPAircraftSpecMatrixRelationships = {
	.aircraftType = @"aircraftType",
};

@implementation NJOPAircraftSpecMatrixID
@end

@implementation _NJOPAircraftSpecMatrix

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AircraftSpecMatrix" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AircraftSpecMatrix";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AircraftSpecMatrix" inManagedObjectContext:moc_];
}

- (NJOPAircraftSpecMatrixID*)objectID {
	return (NJOPAircraftSpecMatrixID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"passengerCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"passengerCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic highSpeedDistanceInKPHForNJA;

@dynamic highSpeedDistanceInKPHForNJE;

@dynamic highSpeedDistanceInMPHForNJA;

@dynamic highSpeedDistanceInMPHForNJE;

@dynamic longRangeDistanceInKPHForNJA;

@dynamic longRangeDistanceInKPHForNJE;

@dynamic longRangeDistanceInMPHForNJA;

@dynamic longRangeDistanceInMPHForNJE;

@dynamic passengerCount;

- (int16_t)passengerCountValue {
	NSNumber *result = [self passengerCount];
	return [result shortValue];
}

- (void)setPassengerCountValue:(int16_t)value_ {
	[self setPassengerCount:@(value_)];
}

- (int16_t)primitivePassengerCountValue {
	NSNumber *result = [self primitivePassengerCount];
	return [result shortValue];
}

- (void)setPrimitivePassengerCountValue:(int16_t)value_ {
	[self setPrimitivePassengerCount:@(value_)];
}

@dynamic rangeInHours;

@dynamic rangeMapDistanceInKPHForNJA;

@dynamic rangeMapDistanceInKPHForNJE;

@dynamic typeName;

@dynamic aircraftType;

@end

