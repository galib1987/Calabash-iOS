// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPMasterAircraftTypeGroup.h instead.

@import CoreData;
#import "NJOPAircraftTypeGroup.h"

extern const struct NJOPMasterAircraftTypeGroupAttributes {
	__unsafe_unretained NSString *typeGroupNameForNJA;
	__unsafe_unretained NSString *typeGroupNameForNJE;
} NJOPMasterAircraftTypeGroupAttributes;

@interface NJOPMasterAircraftTypeGroupID : NJOPAircraftTypeGroupID {}
@end

@interface _NJOPMasterAircraftTypeGroup : NJOPAircraftTypeGroup {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPMasterAircraftTypeGroupID* objectID;

@property (nonatomic, strong) NSString* typeGroupNameForNJA;

//- (BOOL)validateTypeGroupNameForNJA:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* typeGroupNameForNJE;

//- (BOOL)validateTypeGroupNameForNJE:(id*)value_ error:(NSError**)error_;

@end

@interface _NJOPMasterAircraftTypeGroup (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTypeGroupNameForNJA;
- (void)setPrimitiveTypeGroupNameForNJA:(NSString*)value;

- (NSString*)primitiveTypeGroupNameForNJE;
- (void)setPrimitiveTypeGroupNameForNJE:(NSString*)value;

@end
