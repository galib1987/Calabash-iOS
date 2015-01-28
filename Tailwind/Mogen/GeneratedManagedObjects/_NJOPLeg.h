// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPLeg.h instead.

@import CoreData;

extern const struct NJOPLegAttributes {
	__unsafe_unretained NSString *actualAircraft;
	__unsafe_unretained NSString *arrTime;
	__unsafe_unretained NSString *cateringJSON;
	__unsafe_unretained NSString *crewJSON;
	__unsafe_unretained NSString *depTime;
	__unsafe_unretained NSString *groundJSON;
	__unsafe_unretained NSString *isFlown;
	__unsafe_unretained NSString *isInternational;
	__unsafe_unretained NSString *legID;
	__unsafe_unretained NSString *tailNumber;
} NJOPLegAttributes;

extern const struct NJOPLegRelationships {
	__unsafe_unretained NSString *arrLocation;
	__unsafe_unretained NSString *depLocation;
	__unsafe_unretained NSString *request;
} NJOPLegRelationships;

@class NJOPLocation;
@class NJOPLocation;
@class NJOPRequest2;

@class NSObject;

@class NSObject;

@class NSObject;

@interface NJOPLegID : NSManagedObjectID {}
@end

@interface _NJOPLeg : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPLegID* objectID;

@property (nonatomic, strong) NSString* actualAircraft;

//- (BOOL)validateActualAircraft:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* arrTime;

//- (BOOL)validateArrTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) id cateringJSON;

//- (BOOL)validateCateringJSON:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) id crewJSON;

//- (BOOL)validateCrewJSON:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* depTime;

//- (BOOL)validateDepTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) id groundJSON;

//- (BOOL)validateGroundJSON:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isFlown;

@property (atomic) BOOL isFlownValue;
- (BOOL)isFlownValue;
- (void)setIsFlownValue:(BOOL)value_;

//- (BOOL)validateIsFlown:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isInternational;

@property (atomic) BOOL isInternationalValue;
- (BOOL)isInternationalValue;
- (void)setIsInternationalValue:(BOOL)value_;

//- (BOOL)validateIsInternational:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* legID;

@property (atomic) int32_t legIDValue;
- (int32_t)legIDValue;
- (void)setLegIDValue:(int32_t)value_;

//- (BOOL)validateLegID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* tailNumber;

//- (BOOL)validateTailNumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPLocation *arrLocation;

//- (BOOL)validateArrLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPLocation *depLocation;

//- (BOOL)validateDepLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPRequest2 *request;

//- (BOOL)validateRequest:(id*)value_ error:(NSError**)error_;

@end

@interface _NJOPLeg (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveActualAircraft;
- (void)setPrimitiveActualAircraft:(NSString*)value;

- (NSDate*)primitiveArrTime;
- (void)setPrimitiveArrTime:(NSDate*)value;

- (id)primitiveCateringJSON;
- (void)setPrimitiveCateringJSON:(id)value;

- (id)primitiveCrewJSON;
- (void)setPrimitiveCrewJSON:(id)value;

- (NSDate*)primitiveDepTime;
- (void)setPrimitiveDepTime:(NSDate*)value;

- (id)primitiveGroundJSON;
- (void)setPrimitiveGroundJSON:(id)value;

- (NSNumber*)primitiveIsFlown;
- (void)setPrimitiveIsFlown:(NSNumber*)value;

- (BOOL)primitiveIsFlownValue;
- (void)setPrimitiveIsFlownValue:(BOOL)value_;

- (NSNumber*)primitiveIsInternational;
- (void)setPrimitiveIsInternational:(NSNumber*)value;

- (BOOL)primitiveIsInternationalValue;
- (void)setPrimitiveIsInternationalValue:(BOOL)value_;

- (NSNumber*)primitiveLegID;
- (void)setPrimitiveLegID:(NSNumber*)value;

- (int32_t)primitiveLegIDValue;
- (void)setPrimitiveLegIDValue:(int32_t)value_;

- (NSString*)primitiveTailNumber;
- (void)setPrimitiveTailNumber:(NSString*)value;

- (NJOPLocation*)primitiveArrLocation;
- (void)setPrimitiveArrLocation:(NJOPLocation*)value;

- (NJOPLocation*)primitiveDepLocation;
- (void)setPrimitiveDepLocation:(NJOPLocation*)value;

- (NJOPRequest2*)primitiveRequest;
- (void)setPrimitiveRequest:(NJOPRequest2*)value;

@end
