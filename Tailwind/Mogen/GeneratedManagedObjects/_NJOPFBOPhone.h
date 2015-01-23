// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NJOPFBOPhone.h instead.

@import CoreData;

extern const struct NJOPFBOPhoneAttributes {
	__unsafe_unretained NSString *area_code_txt;
	__unsafe_unretained NSString *country_code_txt;
	__unsafe_unretained NSString *fbo_id;
	__unsafe_unretained NSString *sys_last_changed_ts;
	__unsafe_unretained NSString *telephone_id;
	__unsafe_unretained NSString *telephone_nbr_txt;
} NJOPFBOPhoneAttributes;

extern const struct NJOPFBOPhoneRelationships {
	__unsafe_unretained NSString *fboPhoneParent;
} NJOPFBOPhoneRelationships;

@class NJOPFBO;

@interface NJOPFBOPhoneID : NSManagedObjectID {}
@end

@interface _NJOPFBOPhone : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NJOPFBOPhoneID* objectID;

@property (nonatomic, strong) NSString* area_code_txt;

//- (BOOL)validateArea_code_txt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* country_code_txt;

//- (BOOL)validateCountry_code_txt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* fbo_id;

@property (atomic) int32_t fbo_idValue;
- (int32_t)fbo_idValue;
- (void)setFbo_idValue:(int32_t)value_;

//- (BOOL)validateFbo_id:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* sys_last_changed_ts;

//- (BOOL)validateSys_last_changed_ts:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* telephone_id;

@property (atomic) int32_t telephone_idValue;
- (int32_t)telephone_idValue;
- (void)setTelephone_idValue:(int32_t)value_;

//- (BOOL)validateTelephone_id:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* telephone_nbr_txt;

//- (BOOL)validateTelephone_nbr_txt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NJOPFBO *fboPhoneParent;

//- (BOOL)validateFboPhoneParent:(id*)value_ error:(NSError**)error_;

@end

@interface _NJOPFBOPhone (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveArea_code_txt;
- (void)setPrimitiveArea_code_txt:(NSString*)value;

- (NSString*)primitiveCountry_code_txt;
- (void)setPrimitiveCountry_code_txt:(NSString*)value;

- (NSNumber*)primitiveFbo_id;
- (void)setPrimitiveFbo_id:(NSNumber*)value;

- (int32_t)primitiveFbo_idValue;
- (void)setPrimitiveFbo_idValue:(int32_t)value_;

- (NSDate*)primitiveSys_last_changed_ts;
- (void)setPrimitiveSys_last_changed_ts:(NSDate*)value;

- (NSNumber*)primitiveTelephone_id;
- (void)setPrimitiveTelephone_id:(NSNumber*)value;

- (int32_t)primitiveTelephone_idValue;
- (void)setPrimitiveTelephone_idValue:(int32_t)value_;

- (NSString*)primitiveTelephone_nbr_txt;
- (void)setPrimitiveTelephone_nbr_txt:(NSString*)value;

- (NJOPFBO*)primitiveFboPhoneParent;
- (void)setPrimitiveFboPhoneParent:(NJOPFBO*)value;

@end
