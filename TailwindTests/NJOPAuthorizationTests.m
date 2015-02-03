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
#import "NJOPFlightHTTPClient.h"

@interface NJOPAuthorizationTests : XCTestCase

@end

@implementation NJOPAuthorizationTests

- (void)test_njop_auth_login_success {
    NSString *username = @"dave@email.com";
    NSString *password = @"abc123ABC";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@""];

    [[NSNotificationCenter defaultCenter] addObserverForName:kAuthenticationSuccessNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
    {
        XCTAssertNotNil(notification,@"valid login will have a notification");
        [expectation fulfill];
    }];
    
    NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:username password:password host:API_HOSTNAME];
    [NCLKeychainStorage saveUserPassword:userPass error:nil];
    [NJOPUser sharedInstance].username = username;
    
    [[NJOPFlightHTTPClient sharedInstance] authenticate];
    
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)test_njop_auth_login_failure {
    NSString *username = @"dave@email.com";
    NSString *password = @"111111";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kAuthenticationFailureNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
         NSError *error = (NSError*)notification.object;
         XCTAssertNotNil(error.description,@"valid failure will have a notification");
         [expectation fulfill];
     }];
    
    NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:username password:password host:API_HOSTNAME];
    [NCLKeychainStorage saveUserPassword:userPass error:nil];
    [NJOPUser sharedInstance].username = username;
    
    [[NJOPFlightHTTPClient sharedInstance] authenticate];
    
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}



@end
