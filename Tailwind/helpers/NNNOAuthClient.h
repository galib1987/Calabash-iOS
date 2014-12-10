//
//  NNNOAuthClient.h
//  OAuthSample
//
//  Created by Ryan Smith on 10/13/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NCLOAuthClient.h"
#import "NCLOAuthCredential.h"

extern NSString * const NNNOAuthClientCredentialDidChange;
extern NSString * const NNNOAuthClientLoginFailed;

typedef void(^NNNOAuthClientRequerstCompletion)(NCLOAuthCredential *credential, NSError* error);
@interface NNNOAuthClient : NCLOAuthClient

+ (NNNOAuthClient*)sharedInstance;

- (void)requestCredential;
- (void)requestCredentialWithCompletion:(NNNOAuthClientRequerstCompletion)completionBlock;

- (void)requestCredentialWithUserName:(NSString*)userName
														 password:(NSString*)password
										completionHandler:(NNNOAuthClientRequerstCompletion)completionBlock;

- (void)refreshCredential;
- (void)refreshWithCompletion:(NNNOAuthClientRequerstCompletion)completionBlock;
- (void)clearCredential;
- (BOOL)isLoginNeeded;

@end
