// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPAccount.m instead.

#import "_NJOPAccount.h"

const struct NJOPAccountAttributes NJOPAccountAttributes = {
	.accountID = @"accountID",
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

@dynamic reservations;

- (NSMutableSet*)reservationsSet {
	[self willAccessValueForKey:@"reservations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"reservations"];

	[self didAccessValueForKey:@"reservations"];
	return result;
}

@end

