// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPContract2.h instead.

@import CoreData;

extern const struct NJOPContract2Attributes {
	__unsafe_unretained NSString *aircraftName;
	__unsafe_unretained NSString *aircraftType;
	__unsafe_unretained NSString *cardNumber;
	__unsafe_unretained NSString *contractID;
	__unsafe_unretained NSString *contractType;
	__unsafe_unretained NSString *peakDates;
	__unsafe_unretained NSString *remainingHoursActual;
	__unsafe_unretained NSString *remainingHoursProjected;
	__unsafe_unretained NSString *tailNumber;
} NJOPContract2Attributes;

extern const struct NJOPContract2Relationships {
	__unsafe_unretained NSString *account;
} NJOPContract2Relationships;

@class NJOPAccount;

@class NSObject;

@interface NJOPContract2ID : NSManagedObjectID {}
@end

@interface _NJOPContract2 : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPContract2ID* objectID;

@property (nonatomic, strong) NSString* aircraftName;

//- (BOOL)validateAircraftName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* aircraftType;

//- (BOOL)validateAircraftType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* cardNumber;

//- (BOOL)validateCardNumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* contractID;

@property (atomic) int32_t contractIDValue;
- (int32_t)contractIDValue;
- (void)setContractIDValue:(int32_t)value_;

//- (BOOL)validateContractID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* contractType;

//- (BOOL)validateContractType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) id peakDates;

//- (BOOL)validatePeakDates:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* remainingHoursActual;

//- (BOOL)validateRemainingHoursActual:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* remainingHoursProjected;

//- (BOOL)validateRemainingHoursProjected:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* tailNumber;

//- (BOOL)validateTailNumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPAccount *account;

//- (BOOL)validateAccount:(id*)value_ error:(NSError**)error_;

@end

@interface _NJOPContract2 (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAircraftName;
- (void)setPrimitiveAircraftName:(NSString*)value;

- (NSString*)primitiveAircraftType;
- (void)setPrimitiveAircraftType:(NSString*)value;

- (NSString*)primitiveCardNumber;
- (void)setPrimitiveCardNumber:(NSString*)value;

- (NSNumber*)primitiveContractID;
- (void)setPrimitiveContractID:(NSNumber*)value;

- (int32_t)primitiveContractIDValue;
- (void)setPrimitiveContractIDValue:(int32_t)value_;

- (NSString*)primitiveContractType;
- (void)setPrimitiveContractType:(NSString*)value;

- (id)primitivePeakDates;
- (void)setPrimitivePeakDates:(id)value;

- (NSDecimalNumber*)primitiveRemainingHoursActual;
- (void)setPrimitiveRemainingHoursActual:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveRemainingHoursProjected;
- (void)setPrimitiveRemainingHoursProjected:(NSDecimalNumber*)value;

- (NSString*)primitiveTailNumber;
- (void)setPrimitiveTailNumber:(NSString*)value;

- (NJOPAccount*)primitiveAccount;
- (void)setPrimitiveAccount:(NJOPAccount*)value;

@end
