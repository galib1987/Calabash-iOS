//
//  NJOPIndividual.m
//  Tailwind
//
//  Created by netjets on 12/16/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPIndividual.h"

@implementation NJOPIndividual


- (NSValueTransformer*)valueTransformerForAttributes:(NSString*)attribute {
    __block NSValueTransformer* result = nil;
    [@{@[
           @"individualId",
           @"defaultAccountId" ] : [NJOPValueTransformer transformerWithBlock:^id(NSString* string) {
        if ([string isKindOfClass:[NSString class]]) {
            NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
            return [formatter numberFromString:string] ? : [NSNull null];
        } else if([string isKindOfClass:[NSNumber class]]) {
            return string;
        }
        return [NSNull null];
    }],
       @[@"firstName",
         @"middleName",
         @"lastName"] : [NJOPValueTransformer transformerWithBlock:^id(NSString* string) {
        if ([string isKindOfClass:[NSString class]]) {
            return string;
        }
        return [NSNull null];
    }]
       
       } enumerateKeysAndObjectsUsingBlock:^(id key, NJOPValueTransformer* obj, BOOL *stop) {
           if ([key containsObject:attribute]) {
               *stop = YES;
               result = obj;
           }
       }];
    
    return result;
}

- (void)updateWithDictionaryRepresentation:(NSDictionary *)dictionaryRepresentation {
    
    [dictionaryRepresentation enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id valueTransformer = [self valueTransformerForAttributes:key];
        if (valueTransformer) {
            id value = [valueTransformer transformedValue:obj];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
    }];
}

+ (instancetype)individualWithDictionaryRepresentation:(NSDictionary *)dictionaryRepresentation {
    id instance = [self new];
    [instance updateWithDictionaryRepresentation:dictionaryRepresentation];
    return instance;
}

@end
