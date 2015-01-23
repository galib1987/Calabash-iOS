// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPRequest2.h instead.

@import CoreData;

extern const struct NJOPRequest2Attributes {
	__unsafe_unretained NSString *requestID;
} NJOPRequest2Attributes;

extern const struct NJOPRequest2Relationships {
	__unsafe_unretained NSString *reservation;
} NJOPRequest2Relationships;

@class NJOPReservation2;

@interface NJOPRequest2ID : NSManagedObjectID {}
@end

@interface _NJOPRequest2 : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPRequest2ID* objectID;

@property (nonatomic, strong) NSNumber* requestID;

@property (atomic) int32_t requestIDValue;
- (int32_t)requestIDValue;
- (void)setRequestIDValue:(int32_t)value_;

//- (BOOL)validateRequestID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPReservation2 *reservation;

//- (BOOL)validateReservation:(id*)value_ error:(NSError**)error_;

@end

@interface _NJOPRequest2 (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveRequestID;
- (void)setPrimitiveRequestID:(NSNumber*)value;

- (int32_t)primitiveRequestIDValue;
- (void)setPrimitiveRequestIDValue:(int32_t)value_;

- (NJOPReservation2*)primitiveReservation;
- (void)setPrimitiveReservation:(NJOPReservation2*)value;

@end
