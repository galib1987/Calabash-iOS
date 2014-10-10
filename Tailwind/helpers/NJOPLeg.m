//
//  NJOPLeg.m
//  Tailwind
//
//  Created by DAVID LIN on 10/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPLeg.h"

@implementation NJOPLeg


- (NSValueTransformer*)valueTransformerForAttributes:(NSString*)attribute {
    __block NSValueTransformer* result = nil;
    [@{@[
           @"legId",
           @"legOrderNbr",
           @"flightRuleId",
           @"flownStatus",
           @"noOfFuelStops",
           @"tailId",
           @"departureFBOId",
           @"departureFBOOverrideReasonCode",
           @"isEtdEnteredByUser",
           @"arrivalFBOId",
           @"isEtaEnteredByUser",
           @"overriddenTripTime" ] : [NJOPValueTransformer transformerWithBlock:^id(NSString* string) {
        if ([string isKindOfClass:[NSString class]]) {
            NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
            return [formatter numberFromString:string] ? : [NSNull null];
        } else if([string isKindOfClass:[NSNumber class]]) {
            return string;
        }
        return [NSNull null];
    }],
       @[@"estimatedFlightTime",
         @"estimatedFlightDistanceInKM",
         @"estimatedTripTime"] : [NJOPValueTransformer transformerWithBlock:^id(NSString* string) {
        if ([string isKindOfClass:[NSString class]]) {
            NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            return [formatter numberFromString:string] ? : [NSNull null];
        } else if([string isKindOfClass:[NSNumber class]]) {
            return string;
        }
        return [NSNull null];
    }],
       @[@"etd",
         @"outTime",
         @"atd",
         @"eta",
         @"inTime"] : [NJOPValueTransformer transformerWithBlock:^id(NSString* string) {
        if ([string isKindOfClass:[NSString class]]) {
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
            return [formatter dateFromString:string] ? : [NSNull null];
        } else if([string isKindOfClass:[NSDate class]]) {
            return string;
        }
        return [NSNull null];
    }],
       @[@"flownStatusDescription",
         @"tailNumber",
         @"departureFBOName",
         @"departureFBOOverrideReasonDescription",
         @"departureFBOOverrideReasonExplanation",
         @"departureAirportId",
         @"departureAirportName",
         @"departureAirportCity",
         @"departureAirportState",
         @"departureAirportCountry",
         @"arrivalFBOName",
         @"arrivalAirportId",
         @"arrivalAirportName",
         @"arrivalAirportCity",
         @"arrivalAirportState",
         @"arrivalAirportCountry",
         @"overriddenTripTimeReason"] : [NJOPValueTransformer transformerWithBlock:^id(NSString* string) {
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

+ (instancetype)legWithDictionaryRepresentation:(NSDictionary *)dictionaryRepresentation {
    id instance = [self new];
    [instance updateWithDictionaryRepresentation:dictionaryRepresentation];
    return instance;
}


@end
