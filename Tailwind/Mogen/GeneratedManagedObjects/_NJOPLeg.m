// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPLeg.m instead.

#import "_NJOPLeg.h"

const struct NJOPLegAttributes NJOPLegAttributes = {
	.actualAircraft = @"actualAircraft",
	.arrTime = @"arrTime",
	.cateringJSON = @"cateringJSON",
	.crewJSON = @"crewJSON",
	.depTime = @"depTime",
	.groundJSON = @"groundJSON",
	.isFlown = @"isFlown",
	.isInternational = @"isInternational",
	.legID = @"legID",
	.tailNumber = @"tailNumber",
};

const struct NJOPLegRelationships NJOPLegRelationships = {
	.arrLocation = @"arrLocation",
	.depLocation = @"depLocation",
	.request = @"request",
};

@implementation NJOPLegID
@end

@implementation _NJOPLeg

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Leg" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Leg";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Leg" inManagedObjectContext:moc_];
}

- (NJOPLegID*)objectID {
	return (NJOPLegID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"isFlownValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFlown"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isInternationalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isInternational"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"legIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"legID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic actualAircraft;

@dynamic arrTime;

@dynamic cateringJSON;

@dynamic crewJSON;

@dynamic depTime;

@dynamic groundJSON;

@dynamic isFlown;

- (BOOL)isFlownValue {
	NSNumber *result = [self isFlown];
	return [result boolValue];
}

- (void)setIsFlownValue:(BOOL)value_ {
	[self setIsFlown:@(value_)];
}

- (BOOL)primitiveIsFlownValue {
	NSNumber *result = [self primitiveIsFlown];
	return [result boolValue];
}

- (void)setPrimitiveIsFlownValue:(BOOL)value_ {
	[self setPrimitiveIsFlown:@(value_)];
}

@dynamic isInternational;

- (BOOL)isInternationalValue {
	NSNumber *result = [self isInternational];
	return [result boolValue];
}

- (void)setIsInternationalValue:(BOOL)value_ {
	[self setIsInternational:@(value_)];
}

- (BOOL)primitiveIsInternationalValue {
	NSNumber *result = [self primitiveIsInternational];
	return [result boolValue];
}

- (void)setPrimitiveIsInternationalValue:(BOOL)value_ {
	[self setPrimitiveIsInternational:@(value_)];
}

@dynamic legID;

- (int32_t)legIDValue {
	NSNumber *result = [self legID];
	return [result intValue];
}

- (void)setLegIDValue:(int32_t)value_ {
	[self setLegID:@(value_)];
}

- (int32_t)primitiveLegIDValue {
	NSNumber *result = [self primitiveLegID];
	return [result intValue];
}

- (void)setPrimitiveLegIDValue:(int32_t)value_ {
	[self setPrimitiveLegID:@(value_)];
}

@dynamic tailNumber;

@dynamic arrLocation;

@dynamic depLocation;

@dynamic request;

@end

