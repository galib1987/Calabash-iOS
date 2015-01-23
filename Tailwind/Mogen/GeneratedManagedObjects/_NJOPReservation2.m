// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPReservation2.m instead.

#import "_NJOPReservation2.h"

const struct NJOPReservation2Attributes NJOPReservation2Attributes = {
	.reservationID = @"reservationID",
};

const struct NJOPReservation2Relationships NJOPReservation2Relationships = {
	.account = @"account",
	.requests = @"requests",
};

@implementation NJOPReservation2ID
@end

@implementation _NJOPReservation2

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Reservation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Reservation" inManagedObjectContext:moc_];
}

- (NJOPReservation2ID*)objectID {
	return (NJOPReservation2ID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"reservationIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"reservationID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic reservationID;

- (int32_t)reservationIDValue {
	NSNumber *result = [self reservationID];
	return [result intValue];
}

- (void)setReservationIDValue:(int32_t)value_ {
	[self setReservationID:@(value_)];
}

- (int32_t)primitiveReservationIDValue {
	NSNumber *result = [self primitiveReservationID];
	return [result intValue];
}

- (void)setPrimitiveReservationIDValue:(int32_t)value_ {
	[self setPrimitiveReservationID:@(value_)];
}

@dynamic account;

@dynamic requests;

- (NSMutableSet*)requestsSet {
	[self willAccessValueForKey:@"requests"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"requests"];

	[self didAccessValueForKey:@"requests"];
	return result;
}

@end

