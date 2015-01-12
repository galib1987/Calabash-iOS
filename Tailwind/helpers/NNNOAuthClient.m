//
//  NNNOAuthClient.m
//  OAuthSample
//
//  Created by Ryan Smith on 10/13/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NNNOAuthClient.h"
#import "NCLNetworking_Private.h"
#import "NNNUserDefaultsManager.h"

NSString * const NNNOAuthClientCredentialDidChange = @"OAuth client credential did change";
NSString * const NNNOAuthClientLoginFailed = @"OAuth client login Failed";



@implementation NNNOAuthClient

+ (NNNOAuthClient*)sharedInstance
{
    static dispatch_once_t pred;
    static NNNOAuthClient *sharedInstance = nil;
    
    dispatch_once
    (&pred, ^
     {
         sharedInstance = [[self alloc] init];
     });
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
//        [self clearStoredUsernameAndPassword];
    }
    return self;
}

- (BOOL)isSecure
{
    return [[NNNUserDefaultsManager sharedInstance] isSecure];;
}

- (NSString*)host
{
//    return [[NNNUserDefaultsManager sharedInstance] host];
    return @"servicesdev.netjets.com";
}

- (NSInteger)port
{
    return [[NNNUserDefaultsManager sharedInstance] port];
}

- (NSString*)basePath
{
    return @"/auth/oauth/v2/token";
}

- (NSString *)serviceProviderIdentifier
{
    return [NCLNetworking secondLevelDomainForHost:[self host]];
}

- (NSString *)clientID
{
    return @"63bfa6c7-ebc3-44e3-80e4-bc6b8fa1f55a";
//    return @"a732fd75-0194-4795-b999-d0967740ae7b";
}

- (NSString *)secret
{
    return @"ed34b9d6-59f0-4840-82c3-ddb8a7825c29";
//    return @"2a760cab-a840-427c-9422-6d67772f10ad";
}

- (NSString *)user
{
    NSString *username = [[NNNUserDefaultsManager sharedInstance] username] ?: nil;
    
    return username;
}

- (NSString *)storedPassword
{
    if ([self user])
    {
        NCLUserPassword *password = [NCLKeychainStorage userPasswordForUser:[self user] host:[self host]];
        return password.password;
    }
    return nil;
}

- (void)clearStoredUsernameAndPassword
{
    if ([self user])
    {
        [NCLKeychainStorage clearGenericPasswordKeysForHost:[self host]];
        [[NNNUserDefaultsManager sharedInstance] clearUsername];
    }
}

- (BOOL)isLoginNeeded {
	if ([self user] && [[self user] length] > 0 && [self storedPassword] && [[self storedPassword] length] > 0) {
		return NO;
	}
	return YES;
}


-(void)requestCredentialWithUserName:(NSString *)userName password:(NSString *)password completionHandler:(void (^)(NCLOAuthCredential *, NSError *))completionBlock {
	NSString* host = [[NNNUserDefaultsManager sharedInstance] host];
	[[NNNUserDefaultsManager sharedInstance] setUsername:userName];
	NCLUserPassword *userPassword = [[NCLUserPassword alloc] initWithUsername:userName
																																	 password:password
																																			 host:host];
	[NCLKeychainStorage saveUserPassword:userPassword error:nil];


	dispatch_async(dispatch_get_main_queue(), ^{
		[self requestCredentialWithCompletion:completionBlock];
	});
}

#pragma mark -

- (void)requestCredential
{
    [self requestCredentialWithCompletion:nil];
}

-(void)requestCredentialWithCompletion:(void (^)(NCLOAuthCredential *, NSError *))completionBlock
{
    if (self.credential)
    {
        if ([self.credential isExpiringSoon] || [self.credential isExpired])
        {
            [self refreshWithCompletion:completionBlock];
        }
        else
        {
            if (completionBlock)
            {
                completionBlock(self.credential,nil);
            }
            return;
        }
    }
    else
    {
			[self authenticateUsingOAuthWithPath:self.basePath
																	username:[self user]
																	password:[self storedPassword]
																		 scope:nil
																	 success:^(NCLOAuthCredential *credential) {
																		 dispatch_async(dispatch_get_main_queue(), ^{
																			 if (completionBlock)
																			 {
																				 completionBlock(credential,nil);
																			 }
																			 [[NSNotificationCenter defaultCenter] postNotificationName:NNNOAuthClientCredentialDidChange object:nil];
																		 });
																	 }
																	 failure:^(NSError *error) {
																		 [self clearStoredUsernameAndPassword];
																		 if (completionBlock) {
																			 completionBlock(nil,error);
																		 }
																		 [[NSNotificationCenter defaultCenter] postNotificationName:NNNOAuthClientLoginFailed object:nil];
																	 }];
    }
}

- (void)refreshCredential
{
    [self refreshWithCompletion:nil];
}

-(void)refreshWithCompletion:(NNNOAuthClientRequerstCompletion)completionBlock
{
    if (self.credential)
    {
        [self authenticateUsingOAuthWithPath:self.basePath
                                refreshToken:self.credential.refreshToken
                                     success:^(NCLOAuthCredential *credential) {
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             if (completionBlock)
                                             {
                                                 completionBlock(credential,nil);
                                             }
                                             [[NSNotificationCenter defaultCenter] postNotificationName:NNNOAuthClientCredentialDidChange object:nil];
                                         });
                                     }
                                     failure:^(NSError *error) {
                                         [self clearStoredUsernameAndPassword];
                                         [[NSNotificationCenter defaultCenter] postNotificationName:NNNOAuthClientCredentialDidChange object:nil];
                                     }];
    }
}

- (void)clearCredential
{
    self.credential = nil;
    [self clearStoredUsernameAndPassword];
    [[NSNotificationCenter defaultCenter] postNotificationName:NNNOAuthClientCredentialDidChange object:nil];
}

@end
