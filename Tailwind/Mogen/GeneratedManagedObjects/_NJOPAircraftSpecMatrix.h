// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPAircraftSpecMatrix.h instead.

@import CoreData;

extern const struct NJOPAircraftSpecMatrixAttributes {
	__unsafe_unretained NSString *highSpeedDistanceInKPHForNJA;
	__unsafe_unretained NSString *highSpeedDistanceInKPHForNJE;
	__unsafe_unretained NSString *highSpeedDistanceInMPHForNJA;
	__unsafe_unretained NSString *highSpeedDistanceInMPHForNJE;
	__unsafe_unretained NSString *longRangeDistanceInKPHForNJA;
	__unsafe_unretained NSString *longRangeDistanceInKPHForNJE;
	__unsafe_unretained NSString *longRangeDistanceInMPHForNJA;
	__unsafe_unretained NSString *longRangeDistanceInMPHForNJE;
	__unsafe_unretained NSString *passengerCount;
	__unsafe_unretained NSString *rangeInHours;
	__unsafe_unretained NSString *rangeMapDistanceInKPHForNJA;
	__unsafe_unretained NSString *rangeMapDistanceInKPHForNJE;
	__unsafe_unretained NSString *typeName;
} NJOPAircraftSpecMatrixAttributes;

extern const struct NJOPAircraftSpecMatrixRelationships {
	__unsafe_unretained NSString *aircraftType;
} NJOPAircraftSpecMatrixRelationships;

@class NJOPAircraftType;

@interface NJOPAircraftSpecMatrixID : NSManagedObjectID {}
@end

@interface _NJOPAircraftSpecMatrix : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPAircraftSpecMatrixID* objectID;

@property (nonatomic, strong) NSDecimalNumber* highSpeedDistanceInKPHForNJA;

//- (BOOL)validateHighSpeedDistanceInKPHForNJA:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* highSpeedDistanceInKPHForNJE;

//- (BOOL)validateHighSpeedDistanceInKPHForNJE:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* highSpeedDistanceInMPHForNJA;

//- (BOOL)validateHighSpeedDistanceInMPHForNJA:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* highSpeedDistanceInMPHForNJE;

//- (BOOL)validateHighSpeedDistanceInMPHForNJE:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* longRangeDistanceInKPHForNJA;

//- (BOOL)validateLongRangeDistanceInKPHForNJA:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* longRangeDistanceInKPHForNJE;

//- (BOOL)validateLongRangeDistanceInKPHForNJE:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* longRangeDistanceInMPHForNJA;

//- (BOOL)validateLongRangeDistanceInMPHForNJA:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* longRangeDistanceInMPHForNJE;

//- (BOOL)validateLongRangeDistanceInMPHForNJE:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* passengerCount;

@property (atomic) int16_t passengerCountValue;
- (int16_t)passengerCountValue;
- (void)setPassengerCountValue:(int16_t)value_;

//- (BOOL)validatePassengerCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* rangeInHours;

//- (BOOL)validateRangeInHours:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* rangeMapDistanceInKPHForNJA;

//- (BOOL)validateRangeMapDistanceInKPHForNJA:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* rangeMapDistanceInKPHForNJE;

//- (BOOL)validateRangeMapDistanceInKPHForNJE:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* typeName;

//- (BOOL)validateTypeName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPAircraftType *aircraftType;

//- (BOOL)validateAircraftType:(id*)value_ error:(NSError**)error_;

@end

@interface _NJOPAircraftSpecMatrix (CoreDataGeneratedPrimitiveAccessors)

- (NSDecimalNumber*)primitiveHighSpeedDistanceInKPHForNJA;
- (void)setPrimitiveHighSpeedDistanceInKPHForNJA:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveHighSpeedDistanceInKPHForNJE;
- (void)setPrimitiveHighSpeedDistanceInKPHForNJE:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveHighSpeedDistanceInMPHForNJA;
- (void)setPrimitiveHighSpeedDistanceInMPHForNJA:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveHighSpeedDistanceInMPHForNJE;
- (void)setPrimitiveHighSpeedDistanceInMPHForNJE:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveLongRangeDistanceInKPHForNJA;
- (void)setPrimitiveLongRangeDistanceInKPHForNJA:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveLongRangeDistanceInKPHForNJE;
- (void)setPrimitiveLongRangeDistanceInKPHForNJE:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveLongRangeDistanceInMPHForNJA;
- (void)setPrimitiveLongRangeDistanceInMPHForNJA:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveLongRangeDistanceInMPHForNJE;
- (void)setPrimitiveLongRangeDistanceInMPHForNJE:(NSDecimalNumber*)value;

- (NSNumber*)primitivePassengerCount;
- (void)setPrimitivePassengerCount:(NSNumber*)value;

- (int16_t)primitivePassengerCountValue;
- (void)setPrimitivePassengerCountValue:(int16_t)value_;

- (NSDecimalNumber*)primitiveRangeInHours;
- (void)setPrimitiveRangeInHours:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveRangeMapDistanceInKPHForNJA;
- (void)setPrimitiveRangeMapDistanceInKPHForNJA:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveRangeMapDistanceInKPHForNJE;
- (void)setPrimitiveRangeMapDistanceInKPHForNJE:(NSDecimalNumber*)value;

- (NSString*)primitiveTypeName;
- (void)setPrimitiveTypeName:(NSString*)value;

- (NJOPAircraftType*)primitiveAircraftType;
- (void)setPrimitiveAircraftType:(NJOPAircraftType*)value;

@end
