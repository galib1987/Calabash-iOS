// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPLocation.h instead.

@import CoreData;

extern const struct NJOPLocationAttributes {
	__unsafe_unretained NSString *airportID;
	__unsafe_unretained NSString *airportName;
	__unsafe_unretained NSString *fboID;
	__unsafe_unretained NSString *fboName;
	__unsafe_unretained NSString *timeZone;
} NJOPLocationAttributes;

extern const struct NJOPLocationRelationships {
	__unsafe_unretained NSString *arrivalLegs;
	__unsafe_unretained NSString *departureLegs;
} NJOPLocationRelationships;

@class NJOPLeg;
@class NJOPLeg;

@interface NJOPLocationID : NSManagedObjectID {}
@end

@interface _NJOPLocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPLocationID* objectID;

@property (nonatomic, strong) NSString* airportID;

//- (BOOL)validateAirportID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* airportName;

//- (BOOL)validateAirportName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* fboID;

@property (atomic) int32_t fboIDValue;
- (int32_t)fboIDValue;
- (void)setFboIDValue:(int32_t)value_;

//- (BOOL)validateFboID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* fboName;

//- (BOOL)validateFboName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* timeZone;

//- (BOOL)validateTimeZone:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *arrivalLegs;

- (NSMutableSet*)arrivalLegsSet;

@property (nonatomic, strong) NSSet *departureLegs;

- (NSMutableSet*)departureLegsSet;

@end

@interface _NJOPLocation (ArrivalLegsCoreDataGeneratedAccessors)
- (void)addArrivalLegs:(NSSet*)value_;
- (void)removeArrivalLegs:(NSSet*)value_;
- (void)addArrivalLegsObject:(NJOPLeg*)value_;
- (void)removeArrivalLegsObject:(NJOPLeg*)value_;

@end

@interface _NJOPLocation (DepartureLegsCoreDataGeneratedAccessors)
- (void)addDepartureLegs:(NSSet*)value_;
- (void)removeDepartureLegs:(NSSet*)value_;
- (void)addDepartureLegsObject:(NJOPLeg*)value_;
- (void)removeDepartureLegsObject:(NJOPLeg*)value_;

@end

@interface _NJOPLocation (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAirportID;
- (void)setPrimitiveAirportID:(NSString*)value;

- (NSString*)primitiveAirportName;
- (void)setPrimitiveAirportName:(NSString*)value;

- (NSNumber*)primitiveFboID;
- (void)setPrimitiveFboID:(NSNumber*)value;

- (int32_t)primitiveFboIDValue;
- (void)setPrimitiveFboIDValue:(int32_t)value_;

- (NSString*)primitiveFboName;
- (void)setPrimitiveFboName:(NSString*)value;

- (NSString*)primitiveTimeZone;
- (void)setPrimitiveTimeZone:(NSString*)value;

- (NSMutableSet*)primitiveArrivalLegs;
- (void)setPrimitiveArrivalLegs:(NSMutableSet*)value;

- (NSMutableSet*)primitiveDepartureLegs;
- (void)setPrimitiveDepartureLegs:(NSMutableSet*)value;

@end
