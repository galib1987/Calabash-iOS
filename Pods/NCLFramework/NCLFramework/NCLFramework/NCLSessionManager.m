//
//  NCLSessionManager.m
//  NCLFramework
//
//  Created by Chad Long on 6/26/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import "NCLSessionManager.h"
#import "NCLFramework.h"
#import "NCLNetworking_Private.h"

@interface NCLSessionManager()

@property (nonatomic, strong) NSMutableDictionary *sessionHostDict;

@end

@implementation NCLSessionManager

+ (NCLSessionManager*)sharedInstance
{
	static dispatch_once_t pred;
	static NCLSessionManager *sharedInstance = nil;
    
	dispatch_once
    (&pred, ^
     {
         sharedInstance = [[self alloc] init];
         sharedInstance.sessionHostDict = [NSMutableDictionary new];
     });
	
    return sharedInstance;
}

- (void)reset
{
    @synchronized(self)
    {
        // invalidate all existing sessions
        for (NSString *host in self.sessionHostDict)
        {
            NSDictionary *sessionUsernameDict = [self.sessionHostDict objectForKey:host];
            
            for (NSString *username in sessionUsernameDict)
            {
                INFOLog(@"closing URLSession for user: %@; host: %@", username, host);
                
                NCLURLSession *session = [sessionUsernameDict objectForKey:username];
                [session finishTasksAndInvalidate];
            }
        }

        // wipe the array
        [NCLSessionManager sharedInstance].sessionHostDict = [NSMutableDictionary new];
    }
}

- (NCLURLSession*)sessionForUsername:(NSString*)username host:(NSString*)host
{
    if (!host)
        return nil;
    
    static NSString *noUser = @"-UNSPECIFIED-";
    username = username ?: noUser;
    NCLClientCertificate *cert = [NCLKeychainStorage certificateForHost:host];
    
    if (cert)
    {
        username = cert.subjectSummary;
    }
    
    host = [NCLNetworking secondLevelDomainForHost:host];
    
    @synchronized(self)
    {
        NSMutableDictionary *sessionUsernameDict = [self.sessionHostDict objectForKey:host];
        
        if (sessionUsernameDict)
        {
            NCLURLSession *session = [sessionUsernameDict objectForKey:username];
         
            // re-use existing session from cache for same host/users
            if (session)
            {
                return session;
            }
            
            // remove existing sessions for same host/different user
            else
            {
                NCLURLSession *deadSession = nil;
                
                for (NSString *username in sessionUsernameDict)
                {
                    INFOLog(@"closing orphaned URLSession for user: %@; host: %@", username, host);
                    
                    deadSession = [sessionUsernameDict objectForKey:username];
                    [deadSession finishTasksAndInvalidate];
                }
            }
        }

        // if we're still in here, create a new session for host/user
        INFOLog(@"creating new URLSession for user: %@; host: %@", username, host);
        
        [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            NSHTTPCookie *cookie = (NSHTTPCookie*)obj;
            
            if ([[NCLNetworking secondLevelDomainForHost:cookie.domain] isEqualToString:host])
            {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            }
        }];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        config.HTTPShouldUsePipelining = YES;
        config.HTTPShouldSetCookies = YES;
        config.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
        config.HTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        
        NSMutableDictionary *addlHeaders = [[NCLNetworking sharedInstance] standardHeadersForDomain:host];
        
        if (username &&
            [NCLKeychainStorage certificateForHost:host] == nil)
        {
            NCLUserPassword *userPass = [NCLKeychainStorage userPasswordForUser:username host:host];
            
            if (userPass != nil &&
                userPass.password)
            {
                NSString *authStr = [NSString stringWithFormat:@"%@:%@", userPass.username, userPass.password];
                NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
                NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData encodeBase64]];
                [addlHeaders setObject:authValue forKey:@"Authorization"];
            }
        }
        
        config.HTTPAdditionalHeaders = addlHeaders;
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 5;
        
        NCLURLSession *newSession = [NCLURLSession sessionWithConfiguration:config username:username delegateQueue:queue];
        
        // cache the new session for re-use
        sessionUsernameDict = sessionUsernameDict ?: [NSMutableDictionary new];
        [sessionUsernameDict setObject:newSession forKey:username];
        [self.sessionHostDict setObject:sessionUsernameDict forKey:host];
        
        return newSession;
    }
}

@end
