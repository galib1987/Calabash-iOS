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
	
	self.validEmail = @"srahman@email.com";
	self.validPassword = @"abc123ABC";
	self.validAccountId = @(1399142);
	
	NCLUserPassword *userPass = [[NCLUserPassword alloc] initWithUsername:self.validEmail password:self.validPassword host:API_HOSTNAME];
	[NCLKeychainStorage saveUserPassword:userPass error:nil];
	[NJOPUser sharedInstance].username = self.validEmail;
	
	[[NJOPOAuthClient sharedInstance] resetCredential];
	[[NJOPOAuthClient sharedInstance] accessToken:nil];
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	
	// log out here
	
	[super tearDown];
}


- (void)test_caching_callBrief_accountIdNotNil
{
	XCTestExpectation *expectation = [self expectationWithDescription:@"call in progress"];
	
	[[NJOPFlightHTTPClient sharedInstance] loadBriefWithCompletion:^(NSArray *reservations, NSError *error) {
		
		//
		NJOPAccount *account = [[NJOPTailwindPM sharedInstance] accountForID:self.validAccountId createIfNeeded:NO moc:[[NJOPTailwindPM sharedInstance] mainMOC]];
		
		XCTAssertNotNil(account.accountID, @"The account name should not be nil after a brief call");
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
		//
	}];
}

- (void)test_caching_callBrief_accountNameNotNil
{
	XCTestExpectation *expectation = [self expectationWithDescription:@"call in progress"];
	
	[[NJOPFlightHTTPClient sharedInstance] loadBriefWithCompletion:^(NSArray *reservations, NSError *error) {
		
		//
		NJOPAccount *account = [[NJOPTailwindPM sharedInstance] accountForID:self.validAccountId createIfNeeded:NO moc:[[NJOPTailwindPM sharedInstance] mainMOC]];
		
		XCTAssertNotNil(account.accountName, @"The account name should not be nil after a brief call");
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
		//
	}];
}


@end
