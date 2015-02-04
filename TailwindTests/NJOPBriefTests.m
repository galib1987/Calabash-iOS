//
//  NJOPBriefTests.m
//  Tailwind
//
//  Created by Amin on 2015-02-02.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Defines.h"
#import "NJOPUser.h"
#import "NJOPFlightHTTPClient.h"
#import "NJOPOAuthClient.h"
#import "NJOPTailwindPM.h"

@interface NJOPBriefTests : XCTestCase

@property (nonatomic, strong) NSString *validEmail;
@property (nonatomic, strong) NSString *validPassword;
@property (nonatomic, strong) NSNumber *validAccountId;

@end

@implementation NJOPBriefTests

- (void)setUp {
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
	
	self.validEmail = @"dave@email.com";
	self.validPassword = @"abc123ABC";

}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	
	// log out here
	
	[super tearDown];
}

- (void)test_networking_callBrief_individualID {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kBriefLoadSuccessNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
         NSNumber *individualID = [NJOPUser sharedInstance].individualID;
         
         XCTAssertNotNil(individualID,@"got Invdividual ID");
         [expectation fulfill];
     }];
    
    NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:self.validEmail password:self.validPassword host:API_HOSTNAME];
    [NCLKeychainStorage saveUserPassword:userPass error:nil];
    [NJOPUser sharedInstance].username = self.validEmail;
    
    [[NJOPFlightHTTPClient sharedInstance] loadBrief];
    
    
    [self waitForExpectationsWithTimeout:40 handler:nil];
}

- (void)test_networking_callBrief_defaultAccountId {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kBriefLoadSuccessNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
         NSNumber *defaultAccountId = [NJOPUser sharedInstance].defaultAccountID;
         
         XCTAssertNotNil(defaultAccountId,@"got default Account ID");
         [expectation fulfill];
     }];
    
    NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:self.validEmail password:self.validPassword host:API_HOSTNAME];
    [NCLKeychainStorage saveUserPassword:userPass error:nil];
    [NJOPUser sharedInstance].username = self.validEmail;
    
    [[NJOPFlightHTTPClient sharedInstance] loadBrief];
    
    
    [self waitForExpectationsWithTimeout:40 handler:nil];
}

- (void)test_networking_callBrief_firstName {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kBriefLoadSuccessNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
         NSString *firstName = [NJOPUser sharedInstance].firstName;
         
         XCTAssertNotNil(firstName,@"got first name");
         [expectation fulfill];
     }];
    
    NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:self.validEmail password:self.validPassword host:API_HOSTNAME];
    [NCLKeychainStorage saveUserPassword:userPass error:nil];
    [NJOPUser sharedInstance].username = self.validEmail;
    
    [[NJOPFlightHTTPClient sharedInstance] loadBrief];
    
    
    [self waitForExpectationsWithTimeout:40 handler:nil];
}

- (void)test_networking_callBrief_accounts {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kBriefLoadSuccessNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
         NSArray *accounts = [NJOPUser sharedInstance].accounts;
         
         XCTAssert([accounts count] > 0,@"has at least one account");
         [expectation fulfill];
     }];
    
    NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:self.validEmail password:self.validPassword host:API_HOSTNAME];
    [NCLKeychainStorage saveUserPassword:userPass error:nil];
    [NJOPUser sharedInstance].username = self.validEmail;
    
    [[NJOPFlightHTTPClient sharedInstance] loadBrief];
    
    
    [self waitForExpectationsWithTimeout:40 handler:nil];
}

- (void)test_networking_callBrief_reservations {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kBriefLoadSuccessNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
         NSArray *accounts = [NJOPUser sharedInstance].accounts;
         
         XCTAssert([accounts count] > 0,@"has at least one account");
         [expectation fulfill];
     }];
    
    NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:self.validEmail password:self.validPassword host:API_HOSTNAME];
    [NCLKeychainStorage saveUserPassword:userPass error:nil];
    [NJOPUser sharedInstance].username = self.validEmail;
    
    [[NJOPFlightHTTPClient sharedInstance] loadBrief];
    
    
    [self waitForExpectationsWithTimeout:40 handler:nil];
}


@end
