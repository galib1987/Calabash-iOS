// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPRequest2.m instead.

#import "_NJOPRequest2.h"

const struct NJOPRequest2Attributes NJOPRequest2Attributes = {
	.requestID = @"requestID",
};

const struct NJOPRequest2Relationships NJOPRequest2Relationships = {
	.reservation = @"reservation",
};

@implementation NJOPRequest2ID
@end

@implementation _NJOPRequest2

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Request" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Request";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Request" inManagedObjectContext:moc_];
}

- (NJOPRequest2ID*)objectID {
	return (NJOPRequest2ID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"requestIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"requestID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic requestID;

- (int32_t)requestIDValue {
	NSNumber *result = [self requestID];
	return [result intValue];
}

- (void)setRequestIDValue:(int32_t)value_ {
	[self setRequestID:@(value_)];
}

- (int32_t)primitiveRequestIDValue {
	NSNumber *result = [self primitiveRequestID];
	return [result intValue];
}

- (void)setPrimitiveRequestIDValue:(int32_t)value_ {
	[self setPrimitiveRequestID:@(value_)];
}

@dynamic reservation;

@end

