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

@property (nonatomic, strong, readwrite) NSString *_username;
@property (nonatomic, strong, readwrite) NSString *_password;
@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, strong) NSArray *reservations;
@property (nonatomic, strong) NJOPIndividual *individual;
@property (nonatomic, strong) NSArray *accounts;

+ (NJOPOAuthClient*)sharedInstance;

- (void) login:(NSString *)username withPassword:(NSString *) passwd;
@end
