// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPAircraftType.h instead.

@import CoreData;

extern const struct NJOPAircraftTypeAttributes {
	__unsafe_unretained NSString *baggageCapacityInCubicFeet;
	__unsafe_unretained NSString *baggageCapacityInCubicMeters;
	__unsafe_unretained NSString *cabinHeightInFeet;
	__unsafe_unretained NSString *cabinHeightInMeters;
	__unsafe_unretained NSString *cabinLengthInFeet;
	__unsafe_unretained NSString *cabinLengthInMeters;
	__unsafe_unretained NSString *cabinSize;
	__unsafe_unretained NSString *cabinWidthInFeet;
	__unsafe_unretained NSString *cabinWidthInMeters;
	__unsafe_unretained NSString *displayName;
	__unsafe_unretained NSString *displayOrder;
	__unsafe_unretained NSString *highCruiseSpeed;
	__unsafe_unretained NSString *highSpeedKPH;
	__unsafe_unretained NSString *highSpeedMPH;
	__unsafe_unretained NSString *interiorSeatingLengthInFeet;
	__unsafe_unretained NSString *interiorSeatingLengthInMeters;
	__unsafe_unretained NSString *isSignatureSeries;
	__unsafe_unretained NSString *lastChanged;
	__unsafe_unretained NSString *longRangeKPH;
	__unsafe_unretained NSString *longRangeMPH;
	__unsafe_unretained NSString *maxFlyingTime;
	__unsafe_unretained NSString *minRunwayLength;
	__unsafe_unretained NSString *numberOfPax;
	__unsafe_unretained NSString *tagLine1;
	__unsafe_unretained NSString *tagLine2;
	__unsafe_unretained NSString *tagLine3;
	__unsafe_unretained NSString *typeFullName;
	__unsafe_unretained NSString *typeGroupName;
	__unsafe_unretained NSString *typeName;
} NJOPAircraftTypeAttributes;

extern const struct NJOPAircraftTypeRelationships {
	__unsafe_unretained NSString *aircraftSpecs;
} NJOPAircraftTypeRelationships;

@class NJOPAircraftSpecMatrix;

@interface NJOPAircraftTypeID : NSManagedObjectID {}
@end

@interface _NJOPAircraftType : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPAircraftTypeID* objectID;

@property (nonatomic, strong) NSDecimalNumber* baggageCapacityInCubicFeet;

//- (BOOL)validateBaggageCapacityInCubicFeet:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* baggageCapacityInCubicMeters;

//- (BOOL)validateBaggageCapacityInCubicMeters:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* cabinHeightInFeet;

//- (BOOL)validateCabinHeightInFeet:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* cabinHeightInMeters;

//- (BOOL)validateCabinHeightInMeters:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* cabinLengthInFeet;

//- (BOOL)validateCabinLengthInFeet:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* cabinLengthInMeters;

//- (BOOL)validateCabinLengthInMeters:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* cabinSize;

//- (BOOL)validateCabinSize:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* cabinWidthInFeet;

//- (BOOL)validateCabinWidthInFeet:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* cabinWidthInMeters;

//- (BOOL)validateCabinWidthInMeters:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* displayName;

//- (BOOL)validateDisplayName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* displayOrder;

//- (BOOL)validateDisplayOrder:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* highCruiseSpeed;

//- (BOOL)validateHighCruiseSpeed:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* highSpeedKPH;

//- (BOOL)validateHighSpeedKPH:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* highSpeedMPH;

//- (BOOL)validateHighSpeedMPH:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* interiorSeatingLengthInFeet;

//- (BOOL)validateInteriorSeatingLengthInFeet:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* interiorSeatingLengthInMeters;

//- (BOOL)validateInteriorSeatingLengthInMeters:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isSignatureSeries;

@property (atomic) BOOL isSignatureSeriesValue;
- (BOOL)isSignatureSeriesValue;
- (void)setIsSignatureSeriesValue:(BOOL)value_;

//- (BOOL)validateIsSignatureSeries:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* lastChanged;

//- (BOOL)validateLastChanged:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* longRangeKPH;

//- (BOOL)validateLongRangeKPH:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* longRangeMPH;

//- (BOOL)validateLongRangeMPH:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* maxFlyingTime;

//- (BOOL)validateMaxFlyingTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* minRunwayLength;

//- (BOOL)validateMinRunwayLength:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* numberOfPax;

//- (BOOL)validateNumberOfPax:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* tagLine1;

//- (BOOL)validateTagLine1:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* tagLine2;

//- (BOOL)validateTagLine2:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* tagLine3;

//- (BOOL)validateTagLine3:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* typeFullName;

//- (BOOL)validateTypeFullName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* typeGroupName;

//- (BOOL)validateTypeGroupName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* typeName;

//- (BOOL)validateTypeName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *aircraftSpecs;

- (NSMutableSet*)aircraftSpecsSet;

@end

@interface _NJOPAircraftType (AircraftSpecsCoreDataGeneratedAccessors)
- (void)addAircraftSpecs:(NSSet*)value_;
- (void)removeAircraftSpecs:(NSSet*)value_;
- (void)addAircraftSpecsObject:(NJOPAircraftSpecMatrix*)value_;
- (void)removeAircraftSpecsObject:(NJOPAircraftSpecMatrix*)value_;

@end

@interface _NJOPAircraftType (CoreDataGeneratedPrimitiveAccessors)

- (NSDecimalNumber*)primitiveBaggageCapacityInCubicFeet;
- (void)setPrimitiveBaggageCapacityInCubicFeet:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveBaggageCapacityInCubicMeters;
- (void)setPrimitiveBaggageCapacityInCubicMeters:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveCabinHeightInFeet;
- (void)setPrimitiveCabinHeightInFeet:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveCabinHeightInMeters;
- (void)setPrimitiveCabinHeightInMeters:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveCabinLengthInFeet;
- (void)setPrimitiveCabinLengthInFeet:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveCabinLengthInMeters;
- (void)setPrimitiveCabinLengthInMeters:(NSDecimalNumber*)value;

- (NSString*)primitiveCabinSize;
- (void)setPrimitiveCabinSize:(NSString*)value;

- (NSDecimalNumber*)primitiveCabinWidthInFeet;
- (void)setPrimitiveCabinWidthInFeet:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveCabinWidthInMeters;
- (void)setPrimitiveCabinWidthInMeters:(NSDecimalNumber*)value;

- (NSString*)primitiveDisplayName;
- (void)setPrimitiveDisplayName:(NSString*)value;

- (NSDecimalNumber*)primitiveDisplayOrder;
- (void)setPrimitiveDisplayOrder:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveHighCruiseSpeed;
- (void)setPrimitiveHighCruiseSpeed:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveHighSpeedKPH;
- (void)setPrimitiveHighSpeedKPH:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveHighSpeedMPH;
- (void)setPrimitiveHighSpeedMPH:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveInteriorSeatingLengthInFeet;
- (void)setPrimitiveInteriorSeatingLengthInFeet:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveInteriorSeatingLengthInMeters;
- (void)setPrimitiveInteriorSeatingLengthInMeters:(NSDecimalNumber*)value;

- (NSNumber*)primitiveIsSignatureSeries;
- (void)setPrimitiveIsSignatureSeries:(NSNumber*)value;

- (BOOL)primitiveIsSignatureSeriesValue;
- (void)setPrimitiveIsSignatureSeriesValue:(BOOL)value_;

- (NSDate*)primitiveLastChanged;
- (void)setPrimitiveLastChanged:(NSDate*)value;

- (NSDecimalNumber*)primitiveLongRangeKPH;
- (void)setPrimitiveLongRangeKPH:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveLongRangeMPH;
- (void)setPrimitiveLongRangeMPH:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveMaxFlyingTime;
- (void)setPrimitiveMaxFlyingTime:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveMinRunwayLength;
- (void)setPrimitiveMinRunwayLength:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveNumberOfPax;
- (void)setPrimitiveNumberOfPax:(NSDecimalNumber*)value;

- (NSString*)primitiveTagLine1;
- (void)setPrimitiveTagLine1:(NSString*)value;

- (NSString*)primitiveTagLine2;
- (void)setPrimitiveTagLine2:(NSString*)value;

- (NSString*)primitiveTagLine3;
- (void)setPrimitiveTagLine3:(NSString*)value;

- (NSString*)primitiveTypeFullName;
- (void)setPrimitiveTypeFullName:(NSString*)value;

- (NSString*)primitiveTypeGroupName;
- (void)setPrimitiveTypeGroupName:(NSString*)value;

- (NSString*)primitiveTypeName;
- (void)setPrimitiveTypeName:(NSString*)value;

- (NSMutableSet*)primitiveAircraftSpecs;
- (void)setPrimitiveAircraftSpecs:(NSMutableSet*)value;

@end
