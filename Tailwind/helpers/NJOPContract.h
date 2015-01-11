//
//  NJOPContract.h
//  Tailwind
//
//  Created by netjets on 12/16/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NJOPValueTransformer.h"

@interface NJOPContract : NSObject

@property (nonatomic, strong) NSNumber *actualRemainingHours; // 72.4
@property (nonatomic, copy) NSString *aircraftType; // "GV"
@property (nonatomic, copy) NSString *aircraftTypeName; // "GULFSTREAM V"
@property (nonatomic, strong) NSNumber *cardNumber; // null
@property (nonatomic, copy) NSString *cardType; // null
@property (nonatomic, copy) NSString *cardTypeDescription; // null
@property (nonatomic, strong) NSNumber *contractId; // 1408094
@property (nonatomic, strong) NSNumber *contractType; // 7
@property (nonatomic, copy) NSString *contractTypeDescription; // "NJ Lease"
@property (nonatomic, strong) NSNumber *divisionId; // 1411309
@property (nonatomic, copy) NSArray *peakDates; // array of dictionaries
@property (nonatomic, strong) NSNumber *programId; // 1000011
@property (nonatomic, strong) NSNumber *projectedRemainingHours; // 64.4
@property (nonatomic, copy) NSString *tailNumber; // "N509QS"

- (void)updateWithDictionaryRepresentation:(NSDictionary *)dictionaryRepresentation;
+ (instancetype)contractWithDictionaryRepresentation:(NSDictionary *)dictionaryRepresentation;

@end
