// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPMasterAircraftType.h instead.

@import CoreData;
#import "NJOPAircraftType.h"

extern const struct NJOPMasterAircraftTypeAttributes {
	__unsafe_unretained NSString *cabinSizeForNJA;
	__unsafe_unretained NSString *cabinSizeForNJE;
	__unsafe_unretained NSString *typeGroupNameForNJA;
	__unsafe_unretained NSString *typeGroupNameForNJE;
} NJOPMasterAircraftTypeAttributes;

@interface NJOPMasterAircraftTypeID : NJOPAircraftTypeID {}
@end

@interface _NJOPMasterAircraftType : NJOPAircraftType {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPMasterAircraftTypeID* objectID;

@property (nonatomic, strong) NSString* cabinSizeForNJA;

//- (BOOL)validateCabinSizeForNJA:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* cabinSizeForNJE;

//- (BOOL)validateCabinSizeForNJE:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* typeGroupNameForNJA;

//- (BOOL)validateTypeGroupNameForNJA:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* typeGroupNameForNJE;

//- (BOOL)validateTypeGroupNameForNJE:(id*)value_ error:(NSError**)error_;

@end

@interface _NJOPMasterAircraftType (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCabinSizeForNJA;
- (void)setPrimitiveCabinSizeForNJA:(NSString*)value;

- (NSString*)primitiveCabinSizeForNJE;
- (void)setPrimitiveCabinSizeForNJE:(NSString*)value;

- (NSString*)primitiveTypeGroupNameForNJA;
- (void)setPrimitiveTypeGroupNameForNJA:(NSString*)value;

- (NSString*)primitiveTypeGroupNameForNJE;
- (void)setPrimitiveTypeGroupNameForNJE:(NSString*)value;

@end
