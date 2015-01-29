// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPLocation.h instead.

@import CoreData;

extern const struct NJOPLocationAttributes {
	__unsafe_unretained NSString *airportID;
	__unsafe_unretained NSString *airportName;
	__unsafe_unretained NSString *fboID;
	__unsafe_unretained NSString *fboName;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *timeZone;
} NJOPLocationAttributes;

extern const struct NJOPLocationRelationships {
	__unsafe_unretained NSString *arrivalLegs;
	__unsafe_unretained NSString *arrivalRequests;
	__unsafe_unretained NSString *departureLegs;
	__unsafe_unretained NSString *departureRequests;
} NJOPLocationRelationships;

@class NJOPLeg;
@class NJOPRequest2;
@class NJOPLeg;
@class NJOPRequest2;

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

@property (nonatomic, strong) NSDecimalNumber* latitude;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* longitude;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* timeZone;

//- (BOOL)validateTimeZone:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *arrivalLegs;

- (NSMutableSet*)arrivalLegsSet;

@property (nonatomic, strong) NSSet *arrivalRequests;

- (NSMutableSet*)arrivalRequestsSet;

@property (nonatomic, strong) NSSet *departureLegs;

- (NSMutableSet*)departureLegsSet;

@property (nonatomic, strong) NSSet *departureRequests;

- (NSMutableSet*)departureRequestsSet;

@end

@interface _NJOPLocation (ArrivalLegsCoreDataGeneratedAccessors)
- (void)addArrivalLegs:(NSSet*)value_;
- (void)removeArrivalLegs:(NSSet*)value_;
- (void)addArrivalLegsObject:(NJOPLeg*)value_;
- (void)removeArrivalLegsObject:(NJOPLeg*)value_;

@end

@interface _NJOPLocation (ArrivalRequestsCoreDataGeneratedAccessors)
- (void)addArrivalRequests:(NSSet*)value_;
- (void)removeArrivalRequests:(NSSet*)value_;
- (void)addArrivalRequestsObject:(NJOPRequest2*)value_;
- (void)removeArrivalRequestsObject:(NJOPRequest2*)value_;

@end

@interface _NJOPLocation (DepartureLegsCoreDataGeneratedAccessors)
- (void)addDepartureLegs:(NSSet*)value_;
- (void)removeDepartureLegs:(NSSet*)value_;
- (void)addDepartureLegsObject:(NJOPLeg*)value_;
- (void)removeDepartureLegsObject:(NJOPLeg*)value_;

@end

@interface _NJOPLocation (DepartureRequestsCoreDataGeneratedAccessors)
- (void)addDepartureRequests:(NSSet*)value_;
- (void)removeDepartureRequests:(NSSet*)value_;
- (void)addDepartureRequestsObject:(NJOPRequest2*)value_;
- (void)removeDepartureRequestsObject:(NJOPRequest2*)value_;

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

- (NSDecimalNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSDecimalNumber*)value;

- (NSString*)primitiveTimeZone;
- (void)setPrimitiveTimeZone:(NSString*)value;

- (NSMutableSet*)primitiveArrivalLegs;
- (void)setPrimitiveArrivalLegs:(NSMutableSet*)value;

- (NSMutableSet*)primitiveArrivalRequests;
- (void)setPrimitiveArrivalRequests:(NSMutableSet*)value;

- (NSMutableSet*)primitiveDepartureLegs;
- (void)setPrimitiveDepartureLegs:(NSMutableSet*)value;

- (NSMutableSet*)primitiveDepartureRequests;
- (void)setPrimitiveDepartureRequests:(NSMutableSet*)value;

@end
