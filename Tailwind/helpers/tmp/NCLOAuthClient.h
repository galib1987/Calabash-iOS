//
//  NCLOAuthClient.h
//  NCLFramework
//
//  Created by Ryan Smith on 10/7/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import <NCLFramework/NCLFramework.h>

@class NCLOAuthCredential;

@interface NCLOAuthClient : NCLHTTPClient

@property (nonatomic, strong) NCLOAuthCredential *credential;

+ (NCLOAuthClient*)sharedInstance;

- (NSString *)serviceProviderIdentifier;
- (NSString *)clientID;

- (void)authenticateUsingOAuthWithPath:(NSString *)path
                              username:(NSString *)username
                              password:(NSString *)password
                                 scope:(NSString *)scope
                               success:(void (^)(NCLOAuthCredential *credential))success
                               failure:(void (^)(NSError *error))failure;

- (void)authenticateUsingOAuthWithPath:(NSString *)path
                          refreshToken:(NSString *)refreshToken
                               success:(void (^)(NCLOAuthCredential *credential))success
                               failure:(void (^)(NSError *error))failure;
@end
