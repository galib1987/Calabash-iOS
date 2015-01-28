// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPAccount.h instead.

@import CoreData;

extern const struct NJOPAccountAttributes {
	__unsafe_unretained NSString *accountID;
	__unsafe_unretained NSString *accountName;
	__unsafe_unretained NSString *hasBookAuthorization;
	__unsafe_unretained NSString *hasFlyAuthorization;
	__unsafe_unretained NSString *isPrincipal;
	__unsafe_unretained NSString *osrTeamEmail;
	__unsafe_unretained NSString *osrTeamName;
	__unsafe_unretained NSString *osrTeamPhone;
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

@property (nonatomic, strong) NSString* accountName;

//- (BOOL)validateAccountName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* hasBookAuthorization;

@property (atomic) BOOL hasBookAuthorizationValue;
- (BOOL)hasBookAuthorizationValue;
- (void)setHasBookAuthorizationValue:(BOOL)value_;

//- (BOOL)validateHasBookAuthorization:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* hasFlyAuthorization;

@property (atomic) BOOL hasFlyAuthorizationValue;
- (BOOL)hasFlyAuthorizationValue;
- (void)setHasFlyAuthorizationValue:(BOOL)value_;

//- (BOOL)validateHasFlyAuthorization:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isPrincipal;

@property (atomic) BOOL isPrincipalValue;
- (BOOL)isPrincipalValue;
- (void)setIsPrincipalValue:(BOOL)value_;

//- (BOOL)validateIsPrincipal:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* osrTeamEmail;

//- (BOOL)validateOsrTeamEmail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* osrTeamName;

//- (BOOL)validateOsrTeamName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* osrTeamPhone;

//- (BOOL)validateOsrTeamPhone:(id*)value_ error:(NSError**)error_;

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

- (NSString*)primitiveAccountName;
- (void)setPrimitiveAccountName:(NSString*)value;

- (NSNumber*)primitiveHasBookAuthorization;
- (void)setPrimitiveHasBookAuthorization:(NSNumber*)value;

- (BOOL)primitiveHasBookAuthorizationValue;
- (void)setPrimitiveHasBookAuthorizationValue:(BOOL)value_;

- (NSNumber*)primitiveHasFlyAuthorization;
- (void)setPrimitiveHasFlyAuthorization:(NSNumber*)value;

- (BOOL)primitiveHasFlyAuthorizationValue;
- (void)setPrimitiveHasFlyAuthorizationValue:(BOOL)value_;

- (NSNumber*)primitiveIsPrincipal;
- (void)setPrimitiveIsPrincipal:(NSNumber*)value;

- (BOOL)primitiveIsPrincipalValue;
- (void)setPrimitiveIsPrincipalValue:(BOOL)value_;

- (NSString*)primitiveOsrTeamEmail;
- (void)setPrimitiveOsrTeamEmail:(NSString*)value;

- (NSString*)primitiveOsrTeamName;
- (void)setPrimitiveOsrTeamName:(NSString*)value;

- (NSString*)primitiveOsrTeamPhone;
- (void)setPrimitiveOsrTeamPhone:(NSString*)value;

- (NSMutableSet*)primitiveReservations;
- (void)setPrimitiveReservations:(NSMutableSet*)value;

@end
