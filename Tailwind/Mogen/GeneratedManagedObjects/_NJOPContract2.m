// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPContract2.m instead.

#import "_NJOPContract2.h"

const struct NJOPContract2Attributes NJOPContract2Attributes = {
	.aircraftName = @"aircraftName",
	.aircraftType = @"aircraftType",
	.cardNumber = @"cardNumber",
	.contractID = @"contractID",
	.contractType = @"contractType",
	.peakDates = @"peakDates",
	.remainingHoursActual = @"remainingHoursActual",
	.remainingHoursProjected = @"remainingHoursProjected",
	.tailNumber = @"tailNumber",
};

const struct NJOPContract2Relationships NJOPContract2Relationships = {
	.account = @"account",
};

@implementation NJOPContract2ID
@end

@implementation _NJOPContract2

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Contract" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Contract";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Contract" inManagedObjectContext:moc_];
}

- (NJOPContract2ID*)objectID {
	return (NJOPContract2ID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"contractIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"contractID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic aircraftName;

@dynamic aircraftType;

@dynamic cardNumber;

@dynamic contractID;

- (int32_t)contractIDValue {
	NSNumber *result = [self contractID];
	return [result intValue];
}

- (void)setContractIDValue:(int32_t)value_ {
	[self setContractID:@(value_)];
}

- (int32_t)primitiveContractIDValue {
	NSNumber *result = [self primitiveContractID];
	return [result intValue];
}

- (void)setPrimitiveContractIDValue:(int32_t)value_ {
	[self setPrimitiveContractID:@(value_)];
}

@dynamic contractType;

@dynamic peakDates;

@dynamic remainingHoursActual;

@dynamic remainingHoursProjected;

@dynamic tailNumber;

@dynamic account;

@end

