//
//  NJOPAuthorizationTests.m
//  Tailwind
//
//  Created by Amin on 2015-02-02.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Defines.h"
#import "NJOPUser.h"
#import "NJOPOAuthClient.h"

@interface NJOPAuthorizationTests : XCTestCase

@end

@implementation NJOPAuthorizationTests

- (void)test_oAuth_invalidCredentials_tokenNil {
	
	NSString *username = @"aminh@email.com";
	NSString *password = @"abc123ABC";
	
	NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:username password:password host:API_HOSTNAME];
	[NCLKeychainStorage saveUserPassword:userPass error:nil];
	[NJOPUser sharedInstance].username = username;
	
	[[NJOPOAuthClient sharedInstance] resetCredential];
	NSError *err;
	NSString *accessToken = [[NJOPOAuthClient sharedInstance] accessToken:&err];
	
	XCTAssertNil(accessToken, @"Invalid credentials must return nil access token");
}

- (void)test_oAuth_validCredentials_tokenNotNil {
	
	NSString *username = @"srahman@email.com";
	NSString *password = @"abc123ABC";
	
	NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:username password:password host:API_HOSTNAME];
	[NCLKeychainStorage saveUserPassword:userPass error:nil];
	[NJOPUser sharedInstance].username = username;
	
	[[NJOPOAuthClient sharedInstance] resetCredential];
	NSError *err;
	NSString *accessToken = [[NJOPOAuthClient sharedInstance] accessToken:&err];
	
	XCTAssertNotNil(accessToken, @"Valid credentials must return valid access token");
}

- (void)test_oAuth_validCredentials_accountsNonZeroCount {
	
	NSString *username = @"srahman@email.com";
	NSString *password = @"abc123ABC";
	
	NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:username password:password host:API_HOSTNAME];
	[NCLKeychainStorage saveUserPassword:userPass error:nil];
	[NJOPUser sharedInstance].username = username;
	
	[[NJOPOAuthClient sharedInstance] resetCredential];
	NSError *err;
	NSString *accessToken = [[NJOPOAuthClient sharedInstance] accessToken:&err];
	
	XCTAssertTrue(([NJOPOAuthClient sharedInstance].accounts.count > 0), @"Number of accounts must be greater than zero after login with successful credentials");
}


@end
