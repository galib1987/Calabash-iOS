//
//  NCLOAuthClient.h
//  NCLFramework
//
//  Created by Ryan Smith on 10/7/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import <NCLFramework/NCLFramework.h>

@interface NCLOAuthClient : NCLHTTPClient

+ (NCLOAuthClient*)sharedInstance;

- (NSString*)password;
- (NSString*)clientID;
- (NSString*)clientSecret;

- (void)resetCredential;
- (NSString*)accessToken:(NSError**)error;

@end
