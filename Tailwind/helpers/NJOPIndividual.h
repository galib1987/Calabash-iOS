//
//  NJOPIndividual.h
//  Tailwind
//
//  Created by netjets on 12/16/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NJOPValueTransformer.h"

@interface NJOPIndividual : NSObject

@property (nonatomic, strong) NSNumber* individualId;
@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* middleName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSArray * telephones;
@property (nonatomic, strong) NSNumber *defaultAccountId;
@property (nonatomic, copy) NSArray * accounts;


- (void)updateWithDictionaryRepresentation:(NSDictionary *)dictionaryRepresentation;
+ (instancetype)individualWithDictionaryRepresentation:(NSDictionary *)dictionaryRepresentation;

@end
