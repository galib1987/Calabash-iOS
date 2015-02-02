//
//  NJOPOAuthClient.h
//  Tailwind
//
//  Created by Chad Long on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NCLOAuthClient.h"
#import "NCLKeychainStorage.h"
#import "NJOPIndividual.h"

@interface NJOPOAuthClient : NCLOAuthClient

@property (nonatomic, strong) NSArray *reservations;
@property (nonatomic, strong) NJOPIndividual *individual;
@property (nonatomic, strong) NSArray *accounts;
@property (nonatomic, strong) NSArray *contracts;

+ (NJOPOAuthClient*)sharedInstance;

@end
