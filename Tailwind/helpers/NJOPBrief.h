//
//  NJOPBrief.h
//  Tailwind
//
//  Created by netjets on 12/16/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NJOPRequest.h"
#import "NJOPReservation.h"
#import "NJOPIndividual.h"
#import "NJOPContract.h"

@interface NJOPBrief : NSObject

@property (nonatomic, strong, readwrite) NSNumber *totalRequestCount; // number of requests
@property (nonatomic, strong, readwrite) NJOPIndividual *individual; // the person's info
@property (nonatomic, strong, readwrite) NSMutableArray *contracts; // contracts that the person is associated with

@end
