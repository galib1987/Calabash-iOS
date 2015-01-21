//
//  NCLRemoteDataService.m
//  FliteDeck
//
//  Created by Chad Long on 5/21/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import "NCLFramework.h"
#import "NCLHTTPClient.h"
#import "NSString+Utility.h"
#import "NCLUserPassword.h"
#import "NCLClientCertificate.h"
#import "NCLKeychainStorage.h"
#import "Reachability.h"
#import "NCLURLRequest.h"
#import "NSDate+Utility.h"
#import "NSError+Utility.h"
#import "NSData+Utility.h"
#import "NCLNetworking_Private.h"
#import "NCLAnalytics.h"
#import "NCLAnalyticsEvent.h"
#import "NCLSimulatedHTTPResponse.h"
#import "NCLURLSession.h"
#import "NCLSessionManager.h"

@interface NCLHTTPClient()

@property (nonatomic, strong) NSSet *jsonMIMETypes;
@property (nonatomic, strong) NSSet *xmlMIMETypes;
@property (nonatomic, strong) NSSet *imageMIMETypes;
@property (nonatomic, strong) NSString *sessionUser;
@property (nonatomic, strong) NSString *sessionHost;

@end

@implementation NCLHTTPClient

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    
    return self;
}

- (BOOL)isSecure
{
    // may be overridden by subclasses to provide the protocol (http,https) for this remote service
    return YES;
}

- (NSString*)host
{
    // must be overridden by subclasses to provide the hostname/ip addr for this remote service
    INFOLog(@"host not defined for class");
    
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSInteger)port
{
    // may be overridden by subclasses to provide the port for this remote service
    return 0;
}

- (NSString*)basePath
{
    // may be overridden by subclasses to provide a base path for this remote service
    return nil;
}

- (NSString*)user
{
    // may be overridden by subclasses to provide the user in a basic auth authentication scheme
    return nil;
}

- (NCLOAuthClient*)oAuthClient
{
    // may be overridden by subclasses to provide an oauth http client for the purpose of obtaining an access token
    return nil;
}

- (NCLURLSession*)session
{
    return [[NCLSessionManager sharedInstance] sessionForUsername:(self.user ?: [[self oAuthClient] user]) host:self.host isOAuthClient:[self isOAuthClient]];
}

- (BOOL)isOAuthClient
{
    return [self oAuthClient] || [self isKindOfClass:[NCLOAuthClient class]];
}

#pragma mark - Base request

- (NCLURLRequest*)urlRequestWithPath:(NSString*)urlPath
{
    // get a baseline NCLURLRequest for this http service
    NSString *scheme = self.isSecure == YES ? @"https" : @"http";
    NCLURLRequest *urlRequest = [[NCLURLRequest alloc] initWithScheme:scheme host:self.host port:self.port path:[NSString stringWithFormat:@"%@%@", self.basePath ?: @"", urlPath]];
    
    return urlRequest;
}

- (NSData*)sendHttpRequest:(NCLURLRequest*)httpRequest returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error withBackgroundProcessingBlock:(void(^)(NSData*, NSError*))processingBlock
{
    NSData *data = nil;
    NSHTTPURLResponse *httpResponse = nil;
    NSError *localError = nil;
    
    // validate that the host is reachable
    if (![[NCLNetworking sharedInstance] hasInternetConnection])
    {
        localError = [NCLNetworking HTTPErrorForCode:NSURLErrorNotConnectedToInternet];
        
        if (processingBlock)
            processingBlock(nil, localError);
    }
    
    // setup the session
    NCLURLSession *session = [self session];
    NSString *username = session.username;
    
    // if the service requires basic auth and a user is not specified/set, it is an error condition
    NCLUserPassword *userPass = nil;
    
//    if (!localError &&
//        username && username.length > 0 &&
//        self.isSecure &&
//        [NCLKeychainStorage certificateForHost:httpRequest.host] == nil)
//    {
//        userPass = [NCLKeychainStorage userPasswordForUser:username host:httpRequest.host];
//        
//        if (userPass == nil ||
//            userPass.username == nil ||
//            userPass.username.length == 0 ||
//            userPass.password == nil ||
//            userPass.password.length == 0)
//        {
//            localError = [NSError errorWithDomain:NSURLErrorDomain
//                                             code:kCFURLErrorUserAuthenticationRequired
//                                      description:@"Credentials Not Provided"
//                                    failureReason:@"We cannot authenticate your username or password."
//                               recoverySuggestion:@"Provide a valid username and password."];
//            
//            if (processingBlock)
//                processingBlock(nil, localError);
//        }
//    }

    if (!localError &&
        [self oAuthClient])
    {
        NSString *token = [[self oAuthClient] accessToken:&localError];
        
        if (!localError &&
            token)
        {
            [httpRequest addValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        }
    }
    
    if (!localError)
    {
        // execute the http request... include analytics?
        NCLAnalyticsEvent *networkEvent = nil;
        
        if (httpRequest.shouldSuppressAnalytics == NO &&
            !httpRequest.simulatedHTTPResponse)
        {
            networkEvent = [NCLAnalyticsEvent eventForComponent:@"network" action:[httpRequest.HTTPMethod lowercaseString] value:[httpRequest.URL.path lowercaseString]];
            [networkEvent generateTransactionID];
            [self injectAnalyticsHeadersForRequest:httpRequest transactionID:networkEvent.transactionID];
        }
        
        if (httpRequest.simulatedHTTPResponse) // simulated request for client-side testing?
        {
            INFOLog(@"***SIMULATING http %@ request to: %@",  httpRequest.HTTPMethod,  [httpRequest description]);
            
            data = httpRequest.simulatedHTTPResponse.data;
            httpResponse = [[NSHTTPURLResponse alloc] initWithURL:httpRequest.URL statusCode:httpRequest.simulatedHTTPResponse.httpResponseCode HTTPVersion:nil headerFields:nil];
            localError = httpRequest.simulatedHTTPResponse.error;
            
            [NSThread sleepForTimeInterval:httpRequest.simulatedHTTPResponse.responseDelay];
        }
        else
        {
            // by default, let's support backgrounding for network tasks
            __block UIBackgroundTaskIdentifier backgroundTaskID = UIBackgroundTaskInvalid;
            
            if (httpRequest.shouldSuspendWhenBackgrounded == NO &&
                httpRequest.timeoutInterval < 60.0)
            {
                backgroundTaskID = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(void) {

                    [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskID];
                    backgroundTaskID = UIBackgroundTaskInvalid;
                }];
            }
            else
            {
                INFOLog(@"http request will suspend when app is backgrounded");
            }

            // use NSURLSession
            data = [session executeDataTaskWithRequest:httpRequest returningResponse:&httpResponse error:&localError];

            if (networkEvent)
                [networkEvent updateElapsedTime];
            
            // end the background task if we have one
            if (backgroundTaskID != UIBackgroundTaskInvalid)
            {
                [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskID];
            }
        }

        // validate any expected content types in the response
        if (!localError &&
            httpResponse &&
            httpResponse.statusCode < 400 &&
            httpRequest.contentType != ContentTypeAny)
        {
            NSString *contentType = httpResponse.MIMEType;
            
            if (contentType)
            {
                static dispatch_once_t onceToken;
                
                dispatch_once
                (&onceToken, ^
                 {
                     self.jsonMIMETypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
                     self.xmlMIMETypes = [NSSet setWithObjects:@"application/xml", @"text/xml", nil];
                     self.imageMIMETypes = [NSSet setWithObjects:@"image/tiff", @"image/jpeg", @"image/gif", @"image/png", @"image/ico", @"image/x-icon", @"image/bmp", @"image/x-bmp", @"image/x-xbitmap", @"image/x-win-bitmap", nil];
                 });
                
                NSSet *allowableContentTypes = nil;
                
                if (httpRequest.contentType == ContentTypeJSON)
                {
                    allowableContentTypes = self.jsonMIMETypes;
                }
                else if (httpRequest.contentType == ContentTypeXML)
                {
                    allowableContentTypes = self.xmlMIMETypes;
                }
                else if (httpRequest.contentType == ContentTypeImage)
                {
                    allowableContentTypes = self.imageMIMETypes;
                }
                
                if (allowableContentTypes &&
                    ![allowableContentTypes containsObject:contentType])
                {
                    INFOLog(@"response w/ content type '%@' NOT allowed!", contentType);
                    
                    localError = [NCLNetworking HTTPErrorForCode:NSURLErrorCannotParseResponse];

                    NSMutableDictionary *info = [NSMutableDictionary new];
                    [info setObject:contentType forKey:@"MIMEType"];
                    [info setObject:[data readableStringWithMaxBytes:512] forKey:@"Payload"];
                    networkEvent.eventInfo = info;
                }
            }
        }
        
        // handle known/expected errors
        localError = [NCLNetworking HTTPErrorForData:data response:httpResponse error:localError];
        
        if (localError)
        {
            // clear the password on an unauthorized error (helps prevent account locks)
            if (localError.code == 401)
            {
                // clear any cached oauth credentials
                if ([self oAuthClient])
                {
                    [[self oAuthClient] resetCredential];
                    
                    INFOLog(@"OAuth credential has been reset");
                }
                
                userPass = [NCLKeychainStorage userPasswordForUser:username host:self.host];
                [userPass setPassword:@""];
                [NCLKeychainStorage saveUserPassword:userPass error:nil];
            }
            
            if (processingBlock)
                processingBlock(nil, localError);
        }
        // 200 level http status = OK
        else if (httpResponse.statusCode >= 200 && httpResponse.statusCode <= 204)
        {
            @try
            {
                if (processingBlock)
                    processingBlock(data, nil);
            }
            
            // handle unexpected errors such as parsing (this can leak memory with ARC, but is better than a crash)
            @catch (NSException *exception)
            {
                localError = [NSError errorWithDomain:NSURLErrorDomain code:1 description:[exception name] failureReason:[exception reason]];
                
                if (processingBlock)
                    processingBlock(nil, localError);
            }
        }
        // this is unexpected, and can be caused by unknown issues on the server
        else
        {
            localError = [NSError errorWithDomain:NSURLErrorDomain
                                             code:kCFURLErrorUnknown
                                      description:@"Unexpected Error"
                                    failureReason:[NSString stringWithFormat:@"An unexpected error (%ld) has occurred.", (long)httpResponse.statusCode]];
            
            if (processingBlock)
                processingBlock(nil, localError);
        }
        
        // save this event to the analytics data store
        if (networkEvent)
        {
            networkEvent.error = localError;
            
            if (localError)
            {
                NSString *wifiName = [UIDevice connectedWifiName];
                
                if (wifiName &&
                    wifiName.length > 0)
                {
                    if (!networkEvent.eventInfo)
                        networkEvent.eventInfo = [NSMutableDictionary new];
                        
                    [networkEvent.eventInfo setObject:wifiName forKey:@"wifiName"];
                }
            }

            [NCLAnalytics addEvent:networkEvent];
        }
    }
    
    if (response != 0 && httpResponse)
        *response = httpResponse;
    
    if (error != 0)
        *error = localError;
    
    // show errors
    [self displayErrorForRequest:httpRequest error:localError];
    
    // send notifications (as appropriate)
    [self postNotificationForRequest:httpRequest error:localError];
    
    return data;
}

- (NSData*)sendSynchronousHttpRequest:(NCLURLRequest*)httpRequest returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    return [self sendHttpRequest:httpRequest returningResponse:&*response error:&*error withBackgroundProcessingBlock:nil];
}

- (void)sendHttpRequest:(NCLURLRequest*)httpRequest withBackgroundProcessingBlock:(void(^)(NSData*, NSError*))processingBlock
{
    // create an operation to be executed in the background
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^
    {
        [self sendHttpRequest:httpRequest returningResponse:nil error:nil withBackgroundProcessingBlock:processingBlock];
    }];

    // determine if this operation should be processed serially or concurrently... place it on the appropriate queue
    NSOperationQueue *operationQueue = nil;
    
    if (httpRequest.shouldUseSerialDispatchQueue)
        operationQueue = [NCLNetworking sharedInstance].serialOperationQueue;
    else
        operationQueue = [NCLNetworking sharedInstance].concurrentOperationQueue;
    
    if (httpRequest.threadPriority != ThreadPriorityDefault)
        [operation setThreadPriority:0.0];
    
    [operationQueue addOperation:operation];
}

- (NSData*)GET:(NCLURLRequest*)request parameters:(NSDictionary*)parameters returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    [request setHTTPMethod:@"GET"];
    [request setParameters:parameters];
    
    return [self sendHttpRequest:request returningResponse:&*response error:&*error withBackgroundProcessingBlock:nil];
}

- (void)GET:(NCLURLRequest*)request parameters:(NSDictionary*)parameters completionBlock:(void(^)(NSData*, NSError*))completionBlock
{
    [request setHTTPMethod:@"GET"];
    [request setParameters:parameters];
    
    [self sendHttpRequest:request withBackgroundProcessingBlock:completionBlock];
}

- (NSData*)POST:(NCLURLRequest*)request HTTPBody:(id)data returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    [request setHeadersAndBodyWithData:data httpMethod:@"POST"];
    
    return [self sendHttpRequest:request returningResponse:&*response error:&*error withBackgroundProcessingBlock:nil];
}

- (void)POST:(NCLURLRequest*)request HTTPBody:(id)data completionBlock:(void(^)(NSData*, NSError*))completionBlock
{
    [request setHeadersAndBodyWithData:data httpMethod:@"POST"];
    
    [self sendHttpRequest:request withBackgroundProcessingBlock:completionBlock];
}

- (NSData*)PUT:(NCLURLRequest*)request HTTPBody:(id)data returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    [request setHeadersAndBodyWithData:data httpMethod:@"PUT"];
    
    return [self sendHttpRequest:request returningResponse:&*response error:&*error withBackgroundProcessingBlock:nil];
}

- (void)PUT:(NCLURLRequest*)request HTTPBody:(id)data completionBlock:(void(^)(NSData*, NSError*))completionBlock
{
    [request setHeadersAndBodyWithData:data httpMethod:@"PUT"];
    
    [self sendHttpRequest:request withBackgroundProcessingBlock:completionBlock];
}

- (NSData*)DELETE:(NCLURLRequest*)request HTTPBody:(id)data returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    [request setHeadersAndBodyWithData:data httpMethod:@"DELETE"];
    
    return [self sendHttpRequest:request returningResponse:&*response error:&*error withBackgroundProcessingBlock:nil];
}

- (void)DELETE:(NCLURLRequest*)request HTTPBody:(id)data completionBlock:(void(^)(NSData*, NSError*))completionBlock
{
    [request setHeadersAndBodyWithData:data httpMethod:@"DELETE"];
    
    [self sendHttpRequest:request withBackgroundProcessingBlock:completionBlock];
}

- (void)injectAnalyticsHeadersForRequest:(NCLURLRequest*)httpRequest transactionID:(NSString*)transactionID
{
    if ([NCLAnalytics sharedInstance].active == YES &&
        transactionID)
    {
        [httpRequest setValue:transactionID forHTTPHeaderField:@"Trans-ID"];
        [httpRequest setValue:[NSString stringWithFormat:@"%ld", [NCLNetworking sharedInstance].networkStatus] forHTTPHeaderField:@"Network-Status"];
    }
}

- (void)postNotificationForRequest:(NCLURLRequest *)httpRequest error:(NSError *)error
{
    // success notification when requested
    if (!error &&
        httpRequest.notificationNameOnSuccess)
    {
        dispatch_async
        (dispatch_get_main_queue(), ^
         {
             INFOLog(@"sending %@ notification", httpRequest.notificationNameOnSuccess);
             
             [[NSNotificationCenter defaultCenter] postNotificationName:httpRequest.notificationNameOnSuccess object:httpRequest.notificationID];
         });
    }

    // failure notification when requested
    else if (error &&
        httpRequest.notificationNameOnFailure)
    {
        dispatch_async
        (dispatch_get_main_queue(), ^
         {
             INFOLog(@"sending %@ notification", httpRequest.notificationNameOnFailure);
             
             [[NSNotificationCenter defaultCenter] postNotificationName:httpRequest.notificationNameOnFailure object:error];
         });
    }
    
    // post notification that processing is complete... include a call identifier and any error data in the notification
    else if (httpRequest.notificationName)
    {
        NSArray *keys = [NSArray arrayWithObjects:
                         HTTP_REQUEST_ID_NOTIFICATION_KEY,
                         HTTP_REQUEST_ERROR_NOTIFICATION_KEY, nil];
        NSArray *objects = [NSArray arrayWithObjects:
                            (httpRequest.notificationID == nil ? [NSNull null] : httpRequest.notificationID),
                            (error == nil ? [NSNull null] : error), nil];
        NSDictionary *notificationData = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        dispatch_async
        (dispatch_get_main_queue(), ^
         {
             INFOLog(@"sending %@ notification", httpRequest.notificationName);
             
             [[NSNotificationCenter defaultCenter] postNotificationName:httpRequest.notificationName object:self userInfo:notificationData];
         });
    }
}

- (void)displayErrorForRequest:(NCLURLRequest*)httpRequest error:(NSError*)error
{
    // if requested, display an error alert when applicable
    if ([[NCLNetworking sharedInstance] hasInternetConnection] &&
        httpRequest.shouldPresentAlertOnError &&
        error != nil)
    {
        NSString *title = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        NSString *message = [error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey];
        
        if (message == nil)
        {
            message = title;
            title = @"Error";
        }
       
        // display error view
        [NCLFramework presentError:error];
    }
}

@end
