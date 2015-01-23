// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPAircraftTypeGroup.m instead.

#import "_NJOPAircraftTypeGroup.h"

const struct NJOPAircraftTypeGroupAttributes NJOPAircraftTypeGroupAttributes = {
	.acPerformanceTypeName = @"acPerformanceTypeName",
	.baggageCapacity = @"baggageCapacity",
	.cabinHeight = @"cabinHeight",
	.cabinWidth = @"cabinWidth",
	.displayOrder = @"displayOrder",
	.highCruiseSpeed = @"highCruiseSpeed",
	.manufacturer = @"manufacturer",
	.numberOfPax = @"numberOfPax",
	.range = @"range",
	.specsDisclaimerText = @"specsDisclaimerText",
	.typeGroupName = @"typeGroupName",
	.warnings = @"warnings",
};

@implementation NJOPAircraftTypeGroupID
@end

@implementation _NJOPAircraftTypeGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AircraftTypeGroup" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AircraftTypeGroup";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AircraftTypeGroup" inManagedObjectContext:moc_];
}

- (NJOPAircraftTypeGroupID*)objectID {
	return (NJOPAircraftTypeGroupID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"displayOrderValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"displayOrder"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic acPerformanceTypeName;

@dynamic baggageCapacity;

@dynamic cabinHeight;

@dynamic cabinWidth;

@dynamic displayOrder;

- (int16_t)displayOrderValue {
	NSNumber *result = [self displayOrder];
	return [result shortValue];
}

- (void)setDisplayOrderValue:(int16_t)value_ {
	[self setDisplayOrder:@(value_)];
}

- (int16_t)primitiveDisplayOrderValue {
	NSNumber *result = [self primitiveDisplayOrder];
	return [result shortValue];
}

- (void)setPrimitiveDisplayOrderValue:(int16_t)value_ {
	[self setPrimitiveDisplayOrder:@(value_)];
}

@dynamic highCruiseSpeed;

@dynamic manufacturer;

@dynamic numberOfPax;

@dynamic range;

@dynamic specsDisclaimerText;

@dynamic typeGroupName;

@dynamic warnings;

@end

