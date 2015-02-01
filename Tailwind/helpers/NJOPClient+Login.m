//
//  NJOPClient+Login.m
//  NetJets
//
//  Created by NetJets on 9/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPClient+Login.h"
#import "BFTask.h"
#import "BFTaskCompletionSource.h"
#import "NJOPOAuthClient.h"

@interface BFTask (Task) <Task>
@end

@implementation NJOPClient (Login)

+(id<Task>)loginWithUserInputs:(NJOPLoginViewUserInput *)userInput {
	BFTaskCompletionSource* source = [BFTaskCompletionSource taskCompletionSource];
	NSError* error = nil;
	if ([userInput validateWithError:error]) {

//		[[NNNOAuthClient sharedInstance] requestCredentialWithUserName:userInput.username
//																													password:userInput.password
//																								 completionHandler:^(NCLOAuthCredential *credential, NSError* error) {
//																									 if (error) {
//																										 [source setError:error];
//																									 } else {
//																										 [source setResult:credential];
//																									 }
//																								 }];
        NJOPOAuthClient *session = [NJOPOAuthClient sharedInstance];
        //NSLog(@"logging in");
        //NSString *sessionToken = [session login:userInput.username withPassword:userInput.password];
        //session.user = userInput.username;
        //session.password = userInput.password;
	} else {
		[source setError:error];
	}
	return source.task;
}

@end

@interface NJOPLoginViewUserInput ()
@property (nonatomic, strong) NSDictionary* validators;
@end

@implementation NJOPLoginViewUserInput
@synthesize input;

-(instancetype)init {
	self = [super init];
	if (self) {
		self.validators = @{@"username" : [NJOPValidator validatorWithRegex:USERNAME_VALIDATION],
												@"password" : [NJOPValidator validatorWithRegex:PASSWORD_VALIDATION]
												};
	}
	return self;
}

-(BOOL)validateWithError:(NSError *)error {

	__block BOOL result = YES;
	[self.validators enumerateKeysAndObjectsUsingBlock:^(id key, id<NJOPValidator>validator, BOOL *stop) {
		id value = [self valueForKey:key];
		if (value) {
			[validator setInput:value];
			if ([validator validateWithError:nil]) {
				return;
			}
		}
		result = NO;
		*stop = YES;
	}];
	return result;
}

@end


