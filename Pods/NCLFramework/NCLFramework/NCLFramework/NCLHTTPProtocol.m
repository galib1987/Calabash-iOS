//
//  NCLURLProtocol.m
//  WebViewTest
//
//  Created by Chad Long on 7/18/13.
//  Copyright (c) 2013 NetJets. All rights reserved.
//

#import "NCLHTTPProtocol.h"
#import "NCLFramework.h"
#import "NCLNetworking.h"
#import "NCLURLRequest.h"
#import "NSString+Utility.h"
#import "NCLHTTPClient.h"
#import "NCLNetworking_Private.h"
#import "NCLSessionManager.h"
#import "NCLURLSession.h"

@implementation NCLHTTPProtocol

NSString * const protocolHandledKey = @"NCLProtocolHandledKey";
NSString * const protocolKey = @"NCLProtocolKey";
NSString * const protocolClientKey = @"NCLProtocolClientKey";

+ (BOOL)canInitWithRequest:(NSURLRequest*)request
{
    static NSString *httpScheme = @"http";
    static NSString *webKitKey = @"User-Agent";
    static NSString *webKitValue = @"AppleWebKit";
    
    NSString *scheme = [[[request URL] scheme] lowercaseString];

    // use this protocol only for instances of UIWebView
    if ([scheme contains:httpScheme] &&
        [[request allHTTPHeaderFields] objectForKey:webKitKey] &&
        [[[request allHTTPHeaderFields] objectForKey:webKitKey] contains:webKitValue] &&
        
        ([NCLKeychainStorage certificateForHost:request.URL.host] != nil ||
        [[NCLNetworking sharedInstance] userForHost:request.URL.host] != nil) &&
        
        ![NSURLProtocol propertyForKey:protocolKey inRequest:request])
    {
        return YES;
    }
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading
{
    NSMutableURLRequest *newRequest = [self.request mutableCopy];
    [newRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [NSURLProtocol setProperty:@YES forKey:protocolHandledKey inRequest:newRequest];
    [NSURLProtocol setProperty:self forKey:protocolKey inRequest:newRequest];
    [NSURLProtocol setProperty:self.client forKey:protocolClientKey inRequest:newRequest];
    
    NSOperation *operation =
    [NSBlockOperation blockOperationWithBlock:^
     {
         NSString *user = [[[NCLNetworking sharedInstance] userForHost:newRequest.URL.host] mutableCopy];
         
         DEBUGLog(@"routing request through UIWebView interceptor...");
         
         NCLURLSession *session = [[NCLSessionManager sharedInstance] sessionForUsername:user host:newRequest.URL.host];
         [session executeDataTaskWithRequest:newRequest returningResponse:nil error:nil];
     }];
    
    [[NCLNetworking sharedInstance].concurrentOperationQueue addOperation:operation];
}

- (void)stopLoading
{
    
}

@end