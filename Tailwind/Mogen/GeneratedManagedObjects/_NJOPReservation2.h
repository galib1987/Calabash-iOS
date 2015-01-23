// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPReservation2.h instead.

@import CoreData;

extern const struct NJOPReservation2Attributes {
	__unsafe_unretained NSString *reservationID;
} NJOPReservation2Attributes;

extern const struct NJOPReservation2Relationships {
	__unsafe_unretained NSString *account;
	__unsafe_unretained NSString *requests;
} NJOPReservation2Relationships;

@class NJOPAccount;
@class NJOPRequest2;

@interface NJOPReservation2ID : NSManagedObjectID {}
@end

@interface _NJOPReservation2 : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPReservation2ID* objectID;

@property (nonatomic, strong) NSNumber* reservationID;

@property (atomic) int32_t reservationIDValue;
- (int32_t)reservationIDValue;
- (void)setReservationIDValue:(int32_t)value_;

//- (BOOL)validateReservationID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPAccount *account;

//- (BOOL)validateAccount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *requests;

- (NSMutableSet*)requestsSet;

@end

@interface _NJOPReservation2 (RequestsCoreDataGeneratedAccessors)
- (void)addRequests:(NSSet*)value_;
- (void)removeRequests:(NSSet*)value_;
- (void)addRequestsObject:(NJOPRequest2*)value_;
- (void)removeRequestsObject:(NJOPRequest2*)value_;

@end

@interface _NJOPReservation2 (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveReservationID;
- (void)setPrimitiveReservationID:(NSNumber*)value;

- (int32_t)primitiveReservationIDValue;
- (void)setPrimitiveReservationIDValue:(int32_t)value_;

- (NJOPAccount*)primitiveAccount;
- (void)setPrimitiveAccount:(NJOPAccount*)value;

- (NSMutableSet*)primitiveRequests;
- (void)setPrimitiveRequests:(NSMutableSet*)value;

@end
