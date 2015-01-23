// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPAircraftType.m instead.

#import "_NJOPAircraftType.h"

const struct NJOPAircraftTypeAttributes NJOPAircraftTypeAttributes = {
	.baggageCapacityInCubicFeet = @"baggageCapacityInCubicFeet",
	.baggageCapacityInCubicMeters = @"baggageCapacityInCubicMeters",
	.cabinHeightInFeet = @"cabinHeightInFeet",
	.cabinHeightInMeters = @"cabinHeightInMeters",
	.cabinLengthInFeet = @"cabinLengthInFeet",
	.cabinLengthInMeters = @"cabinLengthInMeters",
	.cabinSize = @"cabinSize",
	.cabinWidthInFeet = @"cabinWidthInFeet",
	.cabinWidthInMeters = @"cabinWidthInMeters",
	.displayName = @"displayName",
	.displayOrder = @"displayOrder",
	.highCruiseSpeed = @"highCruiseSpeed",
	.highSpeedKPH = @"highSpeedKPH",
	.highSpeedMPH = @"highSpeedMPH",
	.interiorSeatingLengthInFeet = @"interiorSeatingLengthInFeet",
	.interiorSeatingLengthInMeters = @"interiorSeatingLengthInMeters",
	.isSignatureSeries = @"isSignatureSeries",
	.lastChanged = @"lastChanged",
	.longRangeKPH = @"longRangeKPH",
	.longRangeMPH = @"longRangeMPH",
	.maxFlyingTime = @"maxFlyingTime",
	.minRunwayLength = @"minRunwayLength",
	.numberOfPax = @"numberOfPax",
	.tagLine1 = @"tagLine1",
	.tagLine2 = @"tagLine2",
	.tagLine3 = @"tagLine3",
	.typeFullName = @"typeFullName",
	.typeGroupName = @"typeGroupName",
	.typeName = @"typeName",
};

const struct NJOPAircraftTypeRelationships NJOPAircraftTypeRelationships = {
	.aircraftSpecs = @"aircraftSpecs",
};

@implementation NJOPAircraftTypeID
@end

@implementation _NJOPAircraftType

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AircraftType" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AircraftType";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AircraftType" inManagedObjectContext:moc_];
}

- (NJOPAircraftTypeID*)objectID {
	return (NJOPAircraftTypeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"isSignatureSeriesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isSignatureSeries"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic baggageCapacityInCubicFeet;

@dynamic baggageCapacityInCubicMeters;

@dynamic cabinHeightInFeet;

@dynamic cabinHeightInMeters;

@dynamic cabinLengthInFeet;

@dynamic cabinLengthInMeters;

@dynamic cabinSize;

@dynamic cabinWidthInFeet;

@dynamic cabinWidthInMeters;

@dynamic displayName;

@dynamic displayOrder;

@dynamic highCruiseSpeed;

@dynamic highSpeedKPH;

@dynamic highSpeedMPH;

@dynamic interiorSeatingLengthInFeet;

@dynamic interiorSeatingLengthInMeters;

@dynamic isSignatureSeries;

- (BOOL)isSignatureSeriesValue {
	NSNumber *result = [self isSignatureSeries];
	return [result boolValue];
}

- (void)setIsSignatureSeriesValue:(BOOL)value_ {
	[self setIsSignatureSeries:@(value_)];
}

- (BOOL)primitiveIsSignatureSeriesValue {
	NSNumber *result = [self primitiveIsSignatureSeries];
	return [result boolValue];
}

- (void)setPrimitiveIsSignatureSeriesValue:(BOOL)value_ {
	[self setPrimitiveIsSignatureSeries:@(value_)];
}

@dynamic lastChanged;

@dynamic longRangeKPH;

@dynamic longRangeMPH;

@dynamic maxFlyingTime;

@dynamic minRunwayLength;

@dynamic numberOfPax;

@dynamic tagLine1;

@dynamic tagLine2;

@dynamic tagLine3;

@dynamic typeFullName;

@dynamic typeGroupName;

@dynamic typeName;

@dynamic aircraftSpecs;

- (NSMutableSet*)aircraftSpecsSet {
	[self willAccessValueForKey:@"aircraftSpecs"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"aircraftSpecs"];

	[self didAccessValueForKey:@"aircraftSpecs"];
	return result;
}

@end

