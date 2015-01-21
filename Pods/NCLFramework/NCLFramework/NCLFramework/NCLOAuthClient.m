//
//  NCLOAuthClient.m
//  NCLFramework
//
//  Created by Ryan Smith on 10/7/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import "NCLOAuthClient.h"
#import "NCLNetworking_Private.h"
#import "NCLOAuthCredential.h"
#import "NCLURLRequest.h"

@interface NCLOAuthClient ()

@property (nonatomic, strong, readwrite) NCLOAuthCredential *credential;

@end

@implementation NCLOAuthClient

static NSString *kGrantTypePassword = @"password";
static NSString *kGrantTypeRefreshToken = @"refresh_token";

+ (NCLOAuthClient*)sharedInstance
{
    static dispatch_once_t pred;
    static NCLOAuthClient *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSString*)password
{
    return nil;
}

- (NSString*)clientID
{
    // must be overridden by subclass
    [self doesNotRecognizeSelector:_cmd];

    return nil;
}

- (NSString*)clientSecret
{
    // must be overridden by subclass
    [self doesNotRecognizeSelector:_cmd];

    return nil;
}

- (void)resetCredential
{
    @synchronized(self)
    {
        self.credential = nil;
    }
}

- (NSString*)accessToken:(NSError**)error
{
    @synchronized(self)
    {
        NSMutableDictionary *queryParams = nil;
        
        // if no credential, get a token via user/password auth
        if (!self.credential)
        {
            queryParams = [NSMutableDictionary dictionaryWithDictionary:@{@"grant_type":kGrantTypePassword, @"username":[self user], kGrantTypePassword:[self password]}];
        }
        // if credential is expired or near expired, get a new token via the refresh token
        else if (self.credential && ([self.credential isExpired] || [self.credential isExpiringSoon]))
        {
            queryParams = [NSMutableDictionary dictionaryWithDictionary:@{@"grant_type":kGrantTypeRefreshToken, kGrantTypeRefreshToken:self.credential.refreshToken}];
        }
        
        // if we don't have a viable credential object, update it
        if (queryParams)
        {
            [queryParams addEntriesFromDictionary:@{@"client_id":[self clientID],@"client_secret":[self clientSecret]}];
            
            NSError *credentialError = [self updateCredentialWithParameters:queryParams];
            
            if (credentialError)
            {
                if (error != 0)
                {
                    *error = credentialError;
                }
                
                return nil;
            }
        }
        
        return [self credential].accessToken;
    }
}

- (NSError*)updateCredentialWithParameters:(NSDictionary*)queryParams
{
    NCLURLRequest *request = [self urlRequestWithPath:@""];
    request.parameters = queryParams;
    
    NSError *httpError = nil;
    NSData *data = [self POST:request HTTPBody:nil returningResponse:nil error:&httpError];
    
    if (httpError)
    {
        self.credential = nil;
        
        return httpError;
    }
    else
    {
        id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            // set the access token info
            NCLOAuthCredential *credential = [NCLOAuthCredential credentialWithOAuthToken:responseObject[@"access_token"] tokenType:responseObject[@"token_type"]];
            
            // set refresh token & expiry date
            NSDate *expireDate = [NSDate distantFuture];
            id expiresIn = [responseObject valueForKey:@"expires_in"];
            
            if (expiresIn != nil && ![expiresIn isEqual:[NSNull null]])
            {
                expireDate = [NSDate dateWithTimeIntervalSinceNow:[expiresIn doubleValue]];
            }
            
            [credential setRefreshToken:[responseObject valueForKey:kGrantTypeRefreshToken] expiration:expireDate];
            
            // store the credential in memory
            self.credential = credential;
        }
    }
    
    return nil;
}

//
//- (void)authenticateUsingOAuthWithPath:(NSString *)path
//                              username:(NSString *)username
//                              password:(NSString *)password
//                                 scope:(NSString *)scope
//                               success:(void (^)(NCLOAuthCredential *credential))success
//                               failure:(void (^)(NSError *error))failure
//{
//    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
//    [mutableParameters setObject:@"password" forKey:@"grant_type"];
//    [mutableParameters setValue:username forKey:@"username"];
//    [mutableParameters setValue:password forKey:@"password"];
//    if (scope)
//    {
//        [mutableParameters setValue:scope forKey:@"scope"];
//    }
//    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];
//
//    [self authenticateUsingOAuthWithPath:path parameters:parameters success:success failure:failure];
//}
//
//
//- (void)authenticateUsingOAuthWithPath:(NSString *)path
//                                 scope:(NSString *)scope
//                               success:(void (^)(NCLOAuthCredential *credential))success
//                               failure:(void (^)(NSError *error))failure
//{
//    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
//    [mutableParameters setObject:@"client_credentials" forKey:@"grant_type"];
//    [mutableParameters setValue:scope forKey:@"scope"];
//    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];
//    
//    [self authenticateUsingOAuthWithPath:path parameters:parameters success:success failure:failure];
//}
//
//- (void)authenticateUsingOAuthWithPath:(NSString *)path
//                          refreshToken:(NSString *)refreshToken
//                               success:(void (^)(NCLOAuthCredential *credential))success
//                               failure:(void (^)(NSError *error))failure
//{
//    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
//    [mutableParameters setObject:@"refresh_token" forKey:@"grant_type"];
//    [mutableParameters setValue:refreshToken forKey:@"refresh_token"];
//    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];
//    
//    [self authenticateUsingOAuthWithPath:path parameters:parameters success:success failure:failure];
//}
//
//- (void)authenticateUsingOAuthWithPath:(NSString *)path
//                                  code:(NSString *)code
//                           redirectURI:(NSString *)uri
//                               success:(void (^)(NCLOAuthCredential *credential))success
//                               failure:(void (^)(NSError *error))failure
//{
//    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
//    [mutableParameters setObject:@"authorization_code" forKey:@"grant_type"];
//    [mutableParameters setValue:code forKey:@"code"];
//    [mutableParameters setValue:uri forKey:@"redirect_uri"];
//    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];
//    
//    [self authenticateUsingOAuthWithPath:path parameters:parameters success:success failure:failure];
//}
//
//- (void)authenticateUsingOAuthWithPath:(NSString *)path
//                            parameters:(NSDictionary *)parameters
//                               success:(void (^)(NCLOAuthCredential *credential))success
//                               failure:(void (^)(NSError *error))failure
//{
//    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    [mutableParameters setObject:[self clientID] forKey:@"client_id"];
//    [mutableParameters setValue:[self clientSecret] forKey:@"client_secret"];
//    parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];
//    
//    NSString *scheme = [self isSecure] ? @"https" : @"http";
//    
//    NCLURLRequest *request = [[NCLURLRequest alloc] initWithScheme:scheme host:[self host] port:[self port] path:path];
//    [request setParameters:parameters];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    request.shouldUseSerialDispatchQueue = YES;
//    NSHTTPURLResponse *httpResponse;
//    NSError *error;
//    
//    NSData *data = [self POST:request HTTPBody:parameters returningResponse:&httpResponse error:&error];
//    
//    if (error)
//    {
//        NSLog(@"error:%@", error);
//        failure(error);
//    }
//    else if (data)
//    {
//        id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        if ([responseObject isKindOfClass:[NSDictionary class]])
//        {
//            NCLOAuthCredential *credential = [NCLOAuthCredential credentialWithOAuthToken:responseObject[@"access_token"] tokenType:responseObject[@"token_type"]];
//            
//            NSString *refreshToken = [responseObject valueForKey:@"refresh_token"];
//            if (refreshToken == nil || [refreshToken isEqual:[NSNull null]]) {
//                refreshToken = [parameters valueForKey:@"refresh_token"];
//            }
//            
//            NSDate *expireDate = [NSDate distantFuture];
//            id expiresIn = [responseObject valueForKey:@"expires_in"];
//            if (expiresIn != nil && ![expiresIn isEqual:[NSNull null]]) {
//                expireDate = [NSDate dateWithTimeIntervalSinceNow:[expiresIn doubleValue]];
//            }
//            
//            [credential setRefreshToken:refreshToken expiration:expireDate];
//            
//            self.credential = credential;
//            
//            success(credential);
//        }
//    }
//}

@end
