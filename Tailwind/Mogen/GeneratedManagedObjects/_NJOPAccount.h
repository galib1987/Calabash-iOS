// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPAccount.h instead.

@import CoreData;

extern const struct NJOPAccountAttributes {
	__unsafe_unretained NSString *accountID;
} NJOPAccountAttributes;

extern const struct NJOPAccountRelationships {
	__unsafe_unretained NSString *reservations;
} NJOPAccountRelationships;

@class NJOPReservation2;

@interface NJOPAccountID : NSManagedObjectID {}
@end

@interface _NJOPAccount : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPAccountID* objectID;

@property (nonatomic, strong) NSNumber* accountID;

@property (atomic) int32_t accountIDValue;
- (int32_t)accountIDValue;
- (void)setAccountIDValue:(int32_t)value_;

//- (BOOL)validateAccountID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *reservations;

- (NSMutableSet*)reservationsSet;

@end

@interface _NJOPAccount (ReservationsCoreDataGeneratedAccessors)
- (void)addReservations:(NSSet*)value_;
- (void)removeReservations:(NSSet*)value_;
- (void)addReservationsObject:(NJOPReservation2*)value_;
- (void)removeReservationsObject:(NJOPReservation2*)value_;

@end

@interface _NJOPAccount (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAccountID;
- (void)setPrimitiveAccountID:(NSNumber*)value;

- (int32_t)primitiveAccountIDValue;
- (void)setPrimitiveAccountIDValue:(int32_t)value_;

- (NSMutableSet*)primitiveReservations;
- (void)setPrimitiveReservations:(NSMutableSet*)value;

@end
