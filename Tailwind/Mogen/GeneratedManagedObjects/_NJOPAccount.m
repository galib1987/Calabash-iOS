// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPAccount.m instead.

#import "_NJOPAccount.h"

const struct NJOPAccountAttributes NJOPAccountAttributes = {
	.accountID = @"accountID",
	.accountName = @"accountName",
	.hasBookAuthorization = @"hasBookAuthorization",
	.hasFlyAuthorization = @"hasFlyAuthorization",
	.isPrincipal = @"isPrincipal",
	.osrTeamEmail = @"osrTeamEmail",
	.osrTeamName = @"osrTeamName",
	.osrTeamPhone = @"osrTeamPhone",
};

const struct NJOPAccountRelationships NJOPAccountRelationships = {
	.reservations = @"reservations",
};

@implementation NJOPAccountID
@end

@implementation _NJOPAccount

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Account";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Account" inManagedObjectContext:moc_];
}

- (NJOPAccountID*)objectID {
	return (NJOPAccountID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"accountIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"accountID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"hasBookAuthorizationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasBookAuthorization"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"hasFlyAuthorizationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasFlyAuthorization"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isPrincipalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isPrincipal"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic accountID;

- (int32_t)accountIDValue {
	NSNumber *result = [self accountID];
	return [result intValue];
}

- (void)setAccountIDValue:(int32_t)value_ {
	[self setAccountID:@(value_)];
}

- (int32_t)primitiveAccountIDValue {
	NSNumber *result = [self primitiveAccountID];
	return [result intValue];
}

- (void)setPrimitiveAccountIDValue:(int32_t)value_ {
	[self setPrimitiveAccountID:@(value_)];
}

@dynamic accountName;

@dynamic hasBookAuthorization;

- (BOOL)hasBookAuthorizationValue {
	NSNumber *result = [self hasBookAuthorization];
	return [result boolValue];
}

- (void)setHasBookAuthorizationValue:(BOOL)value_ {
	[self setHasBookAuthorization:@(value_)];
}

- (BOOL)primitiveHasBookAuthorizationValue {
	NSNumber *result = [self primitiveHasBookAuthorization];
	return [result boolValue];
}

- (void)setPrimitiveHasBookAuthorizationValue:(BOOL)value_ {
	[self setPrimitiveHasBookAuthorization:@(value_)];
}

@dynamic hasFlyAuthorization;

- (BOOL)hasFlyAuthorizationValue {
	NSNumber *result = [self hasFlyAuthorization];
	return [result boolValue];
}

- (void)setHasFlyAuthorizationValue:(BOOL)value_ {
	[self setHasFlyAuthorization:@(value_)];
}

- (BOOL)primitiveHasFlyAuthorizationValue {
	NSNumber *result = [self primitiveHasFlyAuthorization];
	return [result boolValue];
}

- (void)setPrimitiveHasFlyAuthorizationValue:(BOOL)value_ {
	[self setPrimitiveHasFlyAuthorization:@(value_)];
}

@dynamic isPrincipal;

- (BOOL)isPrincipalValue {
	NSNumber *result = [self isPrincipal];
	return [result boolValue];
}

- (void)setIsPrincipalValue:(BOOL)value_ {
	[self setIsPrincipal:@(value_)];
}

- (BOOL)primitiveIsPrincipalValue {
	NSNumber *result = [self primitiveIsPrincipal];
	return [result boolValue];
}

- (void)setPrimitiveIsPrincipalValue:(BOOL)value_ {
	[self setPrimitiveIsPrincipal:@(value_)];
}

@dynamic osrTeamEmail;

@dynamic osrTeamName;

@dynamic osrTeamPhone;

@dynamic reservations;

- (NSMutableSet*)reservationsSet {
	[self willAccessValueForKey:@"reservations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"reservations"];

	[self didAccessValueForKey:@"reservations"];
	return result;
}

@end

