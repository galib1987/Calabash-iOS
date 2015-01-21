//
//  NCLOAuthCredential.m
//  NCLFramework
//
//  Created by Ryan Smith on 10/7/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import "NCLOAuthCredential.h"
#import "NCLNetworking_Private.h"

NSString * const kAFOAuthCodeGrantType = @"authorization_code";
NSString * const kAFOAuthClientCredentialsGrantType = @"client_credentials";
NSString * const kAFOAuthPasswordCredentialsGrantType = @"password";
NSString * const kAFOAuthRefreshGrantType = @"refresh_token";



@interface NCLOAuthCredential ()

@property (nonatomic, readwrite) NSString *accessToken;
@property (nonatomic, readwrite) NSString *tokenType;
@property (nonatomic, readwrite) NSString *refreshToken;
@property (nonatomic, readwrite) NSDate *expiration;
@property (nonatomic, readwrite) NSString *host;

@end



@implementation NCLOAuthCredential

+ (instancetype)credentialWithOAuthToken:(NSString *)token tokenType:(NSString *)type
{
    return [[self alloc] initWithOAuthToken:token tokenType:type];
}

- (id)initWithOAuthToken:(NSString *)token tokenType:(NSString *)type
{
    self = [super init];
    if (self)
    {
        _accessToken = token;
        _tokenType = type;
    }
    
    return self;
}

- (void)setRefreshToken:(NSString *)refreshToken expiration:(NSDate *)expiration
{
    self.refreshToken = refreshToken;
    self.expiration = expiration;
}

- (BOOL)isExpired
{
    return [self.expiration compare:[NSDate date]] == NSOrderedAscending;
}

- (BOOL)isExpiringSoon
{
    return [self.expiration compare:[NSDate dateWithTimeIntervalSinceNow:-120]] == NSOrderedAscending;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"OAuth Credential\r\n• accessToken:%@\r\n• tokenType:%@\r\n• refreshToken:%@\r\n• expiration:%@", self.accessToken, self.tokenType, self.refreshToken, self.expiration];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    self.accessToken = [decoder decodeObjectForKey:@"accessToken"];
    self.tokenType = [decoder decodeObjectForKey:@"tokenType"];
    self.refreshToken = [decoder decodeObjectForKey:@"refreshToken"];
    self.expiration = [decoder decodeObjectForKey:@"expiration"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.accessToken forKey:@"accessToken"];
    [encoder encodeObject:self.tokenType forKey:@"tokenType"];
    [encoder encodeObject:self.refreshToken forKey:@"refreshToken"];
    [encoder encodeObject:self.expiration forKey:@"expiration"];
}


@end
