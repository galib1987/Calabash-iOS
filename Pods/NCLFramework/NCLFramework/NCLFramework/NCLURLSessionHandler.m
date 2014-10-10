//
//  NCLURLSessionHandler.m
//  NCLFramework
//
//  Created by Chad Long on 6/23/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import "NCLURLSessionHandler.h"
#import "NCLFramework.h"
#import "NCLHTTPProtocol.h"

@implementation NCLURLSessionHandler

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    if ([challenge previousFailureCount] > 1)
    {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        
        return;
    }
    
    // trust all hosts
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        TRACELog(@"didReceiveServerTrustChallenge: protectionSpace {%@}", challenge.protectionSpace.serverTrust);
        
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
    }
    
    // use basic auth
    else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])
    {
        DEBUGLog(@"didReceiveHTTPBasicChallenge: protectionSpace {%@:%@:%i:%@}",
                 challenge.protectionSpace.protocol, challenge.protectionSpace.host, challenge.protectionSpace.port, challenge.protectionSpace.realm);
        
        NCLUserPassword *userPass = nil;
        
        if (self.username)
        {
            userPass = [NCLKeychainStorage userPasswordForUser:self.username host:challenge.protectionSpace.host];
            
            if (userPass)
            {
                NSURLCredential *cred = [[NSURLCredential alloc] initWithUser:userPass.username
                                                                     password:userPass.password
                                                                  persistence:NSURLCredentialPersistenceForSession];
                
                completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
                
                INFOLog(@"using user/password credentials for session: %@", userPass.username);
            }
        }
        
        if (userPass == nil)
        {
            INFOLog(@"no user/password credentials for user/host %@/%@", self.username, challenge.protectionSpace.host);
            
            completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
        }
    }
    
    // use a client cert
    else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate])
    {
        DEBUGLog(@"didReceiveClientCertificateChallenge: protectionSpace {%@:%@:%i:%@}",
                 challenge.protectionSpace.protocol, challenge.protectionSpace.host, challenge.protectionSpace.port, challenge.protectionSpace.realm);
        
        NCLClientCertificate *certificate = [NCLKeychainStorage certificateForHost:challenge.protectionSpace.host];
        
        if (certificate)
        {
            NSURLCredential *credential = [certificate credential];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
            
            INFOLog(@"using client certificate for session: %@", [certificate subjectSummary]);
        }
        else
        {
            completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
            
            DEBUGLog(@"no client certificate for host %@... continuing without client certificate authentication", challenge.protectionSpace.host);
        }
    }
}

@end
