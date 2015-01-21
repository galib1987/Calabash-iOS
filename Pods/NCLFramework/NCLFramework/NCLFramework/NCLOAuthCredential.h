//
//  NCLOAuthCredential.h
//  NCLFramework
//
//  Created by Ryan Smith on 10/7/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kNCLOAuthCodeGrantType;
extern NSString * const kNCLOAuthClientCredentialsGrantType;
extern NSString * const kNCLOAuthPasswordCredentialsGrantType;
extern NSString * const kNCLOAuthRefreshGrantType;



@interface NCLOAuthCredential : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *accessToken;
@property (nonatomic, readonly) NSString *tokenType;
@property (nonatomic, readonly) NSString *refreshToken;
@property (nonatomic, readonly) NSDate *expiration;
@property (readonly, nonatomic, assign, getter = isExpired) BOOL expired;

+ (instancetype)credentialWithOAuthToken:(NSString *)token tokenType:(NSString *)type;
- (id)initWithOAuthToken:(NSString *)token tokenType:(NSString *)type;

- (void)setRefreshToken:(NSString *)refreshToken expiration:(NSDate *)expiration;
- (BOOL)isExpiringSoon;

@end
