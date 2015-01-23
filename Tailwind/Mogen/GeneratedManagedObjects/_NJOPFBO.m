// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPFBO.m instead.

#import "_NJOPFBO.h"

const struct NJOPFBOAttributes NJOPFBOAttributes = {
	.airportid = @"airportid",
	.fbo_id = @"fbo_id",
	.fbo_ranking_qty = @"fbo_ranking_qty",
	.summer_operating_hour_desc = @"summer_operating_hour_desc",
	.sys_last_changed_ts = @"sys_last_changed_ts",
	.vendor_name = @"vendor_name",
	.winter_operating_hour_desc = @"winter_operating_hour_desc",
};

const struct NJOPFBORelationships NJOPFBORelationships = {
	.fboaddress = @"fboaddress",
	.fbophone = @"fbophone",
};

@implementation NJOPFBOID
@end

@implementation _NJOPFBO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FBO" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FBO";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FBO" inManagedObjectContext:moc_];
}

- (NJOPFBOID*)objectID {
	return (NJOPFBOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"fbo_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fbo_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"fbo_ranking_qtyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fbo_ranking_qty"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic airportid;

@dynamic fbo_id;

- (int32_t)fbo_idValue {
	NSNumber *result = [self fbo_id];
	return [result intValue];
}

- (void)setFbo_idValue:(int32_t)value_ {
	[self setFbo_id:@(value_)];
}

- (int32_t)primitiveFbo_idValue {
	NSNumber *result = [self primitiveFbo_id];
	return [result intValue];
}

- (void)setPrimitiveFbo_idValue:(int32_t)value_ {
	[self setPrimitiveFbo_id:@(value_)];
}

@dynamic fbo_ranking_qty;

- (int16_t)fbo_ranking_qtyValue {
	NSNumber *result = [self fbo_ranking_qty];
	return [result shortValue];
}

- (void)setFbo_ranking_qtyValue:(int16_t)value_ {
	[self setFbo_ranking_qty:@(value_)];
}

- (int16_t)primitiveFbo_ranking_qtyValue {
	NSNumber *result = [self primitiveFbo_ranking_qty];
	return [result shortValue];
}

- (void)setPrimitiveFbo_ranking_qtyValue:(int16_t)value_ {
	[self setPrimitiveFbo_ranking_qty:@(value_)];
}

@dynamic summer_operating_hour_desc;

@dynamic sys_last_changed_ts;

@dynamic vendor_name;

@dynamic winter_operating_hour_desc;

@dynamic fboaddress;

- (NSMutableSet*)fboaddressSet {
	[self willAccessValueForKey:@"fboaddress"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fboaddress"];

	[self didAccessValueForKey:@"fboaddress"];
	return result;
}

@dynamic fbophone;

- (NSMutableSet*)fbophoneSet {
	[self willAccessValueForKey:@"fbophone"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fbophone"];

	[self didAccessValueForKey:@"fbophone"];
	return result;
}

@end

