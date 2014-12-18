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
#import "NCLHTTPClient.h"

@interface NJOPBrief : NCLHTTPClient

@property (nonatomic, strong) NSNumber *totalRequestCount; // number of requests
@property (nonatomic, strong) NJOPIndividual *individual; // the person's info
@property (nonatomic, strong) NSArray *contracts; // contracts that the person is associated with
@property (nonatomic, strong) NSArray * requests; // the requests for the person
@end
