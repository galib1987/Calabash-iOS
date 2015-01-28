//
//  NJOPOAuthClient.m
//  Tailwind
//
//  Created by Chad Long on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPOAuthClient.h"
#import "NJOPUser.h"

@implementation NJOPOAuthClient

+ (NJOPOAuthClient*)sharedInstance
{
    static dispatch_once_t pred;
    static NJOPOAuthClient *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSString*)user
{
    return [NJOPUser sharedInstance].username;
}

- (NSString*)password
{
    return [NCLKeychainStorage userPasswordForUser:self.user host:self.host].password;
}

- (NSString*)clientID
{
    return @"63bfa6c7-ebc3-44e3-80e4-bc6b8fa1f55a";
    //    return @"a732fd75-0194-4795-b999-d0967740ae7b";
}

- (NSString*)clientSecret
{
    return @"ed34b9d6-59f0-4840-82c3-ddb8a7825c29";
    //    return @"2a760cab-a840-427c-9422-6d67772f10ad";
}

- (NSString*)host
{
    return API_HOSTNAME;
}

- (NSString*)basePath
{
    return @"/auth/oauth/v2/token";
}

@end
