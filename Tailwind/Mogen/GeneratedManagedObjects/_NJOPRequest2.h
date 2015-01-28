// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPRequest2.h instead.

@import CoreData;

extern const struct NJOPRequest2Attributes {
	__unsafe_unretained NSString *paxJSON;
	__unsafe_unretained NSString *requestID;
	__unsafe_unretained NSString *requestedAircraft;
	__unsafe_unretained NSString *status;
} NJOPRequest2Attributes;

extern const struct NJOPRequest2Relationships {
	__unsafe_unretained NSString *firstLeg;
	__unsafe_unretained NSString *lastLeg;
	__unsafe_unretained NSString *legs;
	__unsafe_unretained NSString *reservation;
} NJOPRequest2Relationships;

@class NJOPLeg;
@class NJOPLeg;
@class NJOPLeg;
@class NJOPReservation2;

@class NSObject;

@interface NJOPRequest2ID : NSManagedObjectID {}
@end

@interface _NJOPRequest2 : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPRequest2ID* objectID;

@property (nonatomic, strong) id paxJSON;

//- (BOOL)validatePaxJSON:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* requestID;

@property (atomic) int32_t requestIDValue;
- (int32_t)requestIDValue;
- (void)setRequestIDValue:(int32_t)value_;

//- (BOOL)validateRequestID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* requestedAircraft;

//- (BOOL)validateRequestedAircraft:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* status;

//- (BOOL)validateStatus:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPLeg *firstLeg;

//- (BOOL)validateFirstLeg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPLeg *lastLeg;

//- (BOOL)validateLastLeg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *legs;

- (NSMutableSet*)legsSet;

@property (nonatomic, strong) NJOPReservation2 *reservation;

//- (BOOL)validateReservation:(id*)value_ error:(NSError**)error_;

@end

@interface _NJOPRequest2 (LegsCoreDataGeneratedAccessors)
- (void)addLegs:(NSSet*)value_;
- (void)removeLegs:(NSSet*)value_;
- (void)addLegsObject:(NJOPLeg*)value_;
- (void)removeLegsObject:(NJOPLeg*)value_;

@end

@interface _NJOPRequest2 (CoreDataGeneratedPrimitiveAccessors)

- (id)primitivePaxJSON;
- (void)setPrimitivePaxJSON:(id)value;

- (NSNumber*)primitiveRequestID;
- (void)setPrimitiveRequestID:(NSNumber*)value;

- (int32_t)primitiveRequestIDValue;
- (void)setPrimitiveRequestIDValue:(int32_t)value_;

- (NSString*)primitiveRequestedAircraft;
- (void)setPrimitiveRequestedAircraft:(NSString*)value;

- (NSString*)primitiveStatus;
- (void)setPrimitiveStatus:(NSString*)value;

- (NJOPLeg*)primitiveFirstLeg;
- (void)setPrimitiveFirstLeg:(NJOPLeg*)value;

- (NJOPLeg*)primitiveLastLeg;
- (void)setPrimitiveLastLeg:(NJOPLeg*)value;

- (NSMutableSet*)primitiveLegs;
- (void)setPrimitiveLegs:(NSMutableSet*)value;

- (NJOPReservation2*)primitiveReservation;
- (void)setPrimitiveReservation:(NJOPReservation2*)value;

@end
