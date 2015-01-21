//
//  NJOPOAuthClient.m
//  Tailwind
//
//  Created by Chad Long on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPOAuthClient.h"

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
    return self._username;
    //return @"kbrown@email.com";
}

- (NSString*)password
{
    return self._password;
    //return @"abc123ABC";
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

// login is really just getting a session token. If we have one, then we're logged in
// also, we'll do stuff with keychain here
- (void) login:(NSString *)username withPassword:(NSString *) passwd {
    NSLog(@"Logging in username: %@ / password: %@", username, passwd);
    // if we are storing login in keychain
    self.isLoggedIn = NO;
    NSError *error;
    NCLUserPassword *userPass = nil;
    userPass = [NCLKeychainStorage userPasswordForUser:username host:self.host];
    [userPass setPassword:passwd];
    [NCLKeychainStorage saveUserPassword:userPass error:nil];
    NSLog(@"saved login in keychain");
    self._username = username;
    self._password = passwd;
    NSString *token = [self accessToken:&error];
    NSLog(@"access Token is: %@",token);
    if (token != nil && [token length] > 0) {
        self.isLoggedIn = YES;
    } else {
        self.isLoggedIn = NO;
    }
}

@end
