//
//  NCLNetworking.m
//  NCLFramework
//
//  Created by Chad Long on 1/4/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import "NCLNetworking.h"
#import "NCLFramework.h"
#import "NSString+Utility.h"
#import "UIDevice+Utility.h"
#import "NCLHTTPProtocol.h"

#define NETWORKING_HEADER_DEVICE_ID @"Device-ID"
#define NETWORKING_HEADER_APP_VERSION @"App-Version"
#define NETWORKING_HEADER_OS_VERSION @"OS-Version"

@interface NCLNetworking()

@property (nonatomic) NSInteger activityCount;
@property (nonatomic, strong) NSTimer *activityIndicatorVisibilityTimer;

@end

@implementation NCLNetworking
{
    NSMutableDictionary *_appHeaders;
    NSMutableDictionary *_standardHeaders;
    NSMutableDictionary *_authInfo;
    Reachability *_reachability;
}

@synthesize serialOperationQueue = _serialOperationQueue;
@synthesize concurrentOperationQueue = _concurrentOperationQueue;

+ (NCLNetworking*)sharedInstance
{
	static dispatch_once_t pred;
	static NCLNetworking *sharedInstance = nil;
    
	dispatch_once(&pred, ^
    {
        sharedInstance = [[self alloc] init];
        
        sharedInstance.activityCount = 0;
        [NSURLProtocol registerClass:[NCLHTTPProtocol class]];
        
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    });
	
    return sharedInstance;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - http error translations

+ (NSError*)HTTPErrorForCode:(NSInteger)code
{
    return [NCLNetworking HTTPErrorForData:nil response:nil error:[NSError errorWithDomain:NSURLErrorDomain code:code description:nil failureReason:nil]];
}

+ (NSError*)HTTPErrorForData:(NSData*)data response:(NSHTTPURLResponse*)response error:(NSError*)error
{
    NSError *errorTranslation = nil;
    
    // if we get a http 400+ response w/JSON, parse the response for error information
    if (response.statusCode >= 400 &&
        data != nil &&
        [data isKindOfClass:[NSData class]])
    {
        NSError *jsonError = nil;
        NSObject *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (!jsonError &&
            [jsonObject isKindOfClass:[NSDictionary class]])
        {
            NSObject *errorList = [((NSDictionary*)jsonObject) objectForKey:@"errors"];
            
            if (errorList && [errorList isKindOfClass:[NSArray class]])
            {
                jsonObject = ((NSArray*)errorList)[0];
            }
            else if (errorList && [errorList isKindOfClass:[NSDictionary class]])
            {
                jsonObject = errorList; // sometimes not an array when only one exists
            }
        }
        
        if (!jsonError &&
            jsonObject &&
            [jsonObject isKindOfClass:[NSDictionary class]] &&
            [((NSDictionary*)jsonObject) objectForKey:@"code"])
        {
            NSDictionary *payload = ((NSDictionary*)jsonObject);
            NSString *errorDesc = [NSString stringFromObject:[payload objectForKey:@"description"]];
            
            if ([errorDesc contains:@"TransactionRolledbackException"])
            {
                errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                       code:[[NSNumber numberFromObject:[payload objectForKey:@"code"] shouldUseZeroDefault:YES] integerValue]
                                                description:errorDesc
                                              failureReason:@"Operation failed."
                                         recoverySuggestion:@"Please try again."];
            }
            else
            {
                errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                       code:[[NSNumber numberFromObject:[payload objectForKey:@"code"] shouldUseZeroDefault:YES] integerValue]
                                                description:errorDesc
                                              failureReason:nil];
            }
        }
    }
    
    // if the payload didn't have a customized error, let's use a generic one
    if (!errorTranslation)
    {
        // http status of 401 = Unauthorized (basic auth or client cert authentication failure)
        if (response.statusCode == 401 ||
            (error && error.code == NSURLErrorUserCancelledAuthentication))
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:401
                                            description:@"Unauthorized"
                                          failureReason:@"Your username or password cannot be authenticated."
                                     recoverySuggestion:@"Ensure that your account is not locked and that you have provided a valid username and password."];
        }
        // http status of 403 = Forbidden
        else if (response.statusCode == 403)
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:403
                                            description:@"Forbidden"
                                          failureReason:@"You are not authorized to use this service."];
        }
        // http status of 404 = Not found
        else if (response.statusCode == 404 ||
                 (error && error.code == NSURLErrorResourceUnavailable))
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:404
                                            description:@"Resource Not Found"
                                          failureReason:@"This service is currently unavailable."];
        }
        // not connected
        else if (error && error.code == NSURLErrorNotConnectedToInternet)
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:NSURLErrorNotConnectedToInternet
                                            description:@"Not Connected"
                                          failureReason:@"The device appears to be offline."];
        }
        // cant connect to host
        else if (error && (error.code == NSURLErrorCannotConnectToHost || error.code == NSURLErrorCannotFindHost))
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:error.code
                                            description:@"Cannot Connect to Host"
                                          failureReason:@"A connection to the server cannot be established."];
        }
        // network connection lost
        else if (error && (error.code == NSURLErrorNetworkConnectionLost))
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:error.code
                                            description:@"Network Connection Lost"
                                          failureReason:@"The network connection was lost."];
        }
        // unexpected response
        else if (error && error.code == NSURLErrorCannotParseResponse)
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:NSURLErrorCannotParseResponse
                                            description:@"Unexpected Response"
                                          failureReason:@"An unexpected response was received from the network."];
//                                     recoverySuggestion:@"Ensure that the device has a valid network connection."];
        }
        // are we getting a timeout error due to dead wifi?
        else if (error &&
                 error.code == NSURLErrorTimedOut &&
                 [[NCLNetworking sharedInstance] hasDeadWifiConnection])
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:NSURLErrorCannotLoadFromNetwork
                                            description:@"Cannot Connect to Host"
                                          failureReason:@"The WiFi network is not responding."];
//                                     recoverySuggestion:@"Ensure that the device has a valid network connection."];
        }
        // request timed out
        else if (error && error.code == NSURLErrorTimedOut)
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:error.code
                                            description:@"Request Timed Out"
                                          failureReason:@"The request timed out."];
        }
        // catch the rest of the iOS network errors (does not include some http errors)
        else if (error)
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain code:error.code description:@"Connection Error" failureReason:error.localizedDescription];
        }
        // catch the rest of the http errors
        else if (response.statusCode >= 400)
        {
            errorTranslation = [NSError errorWithDomain:NSURLErrorDomain
                                                   code:kCFURLErrorUnknown
                                            description:@"Server Error"
                                          failureReason:[NSString stringWithFormat:@"An unexpected error (%d) has occurred.", response.statusCode]];
        }
    }
    
    return errorTranslation == nil ? error : errorTranslation;
}

#pragma mark - hosts are considered equal if the second level domain is the same (i.e. subdomains are ignored)

+ (NSString*)secondLevelDomainForHost:(NSString*)host
{
    // host is required for uniqueness
    if (host == nil ||
        host.length == 0)
    {
        NSException *exception = [NSException exceptionWithName:@"Exception"
                                                         reason:@"A host is required"
                                                       userInfo:nil];
        @throw exception;
    }
    
    // resolve to second level domain name to make this universal across environments
    host = [host lowercaseString];
    NSArray *domainComponents = [host componentsSeparatedByString: @"."];
    
    if (domainComponents.count > 1)
    {
        host = [NSString stringWithFormat:@"%@.%@", domainComponents[domainComponents.count-2], domainComponents[domainComponents.count-1]];
    }
    
    return host;
}

#pragma mark - networking operation queues

- (NSOperationQueue*)serialOperationQueue
{
    if (_serialOperationQueue == nil)
    {
        @synchronized(self)
        {
            if (_serialOperationQueue == nil)
            {
                _serialOperationQueue = [[NSOperationQueue alloc] init];
                _serialOperationQueue.maxConcurrentOperationCount = 1;
                _serialOperationQueue.name = @"NCLNetworkingSerialOperationQueue";
            }
            
        }
    }
    
    return _serialOperationQueue;
}

- (NSOperationQueue*)concurrentOperationQueue
{
    if (_concurrentOperationQueue == nil)
    {
        @synchronized(self)
        {
            if (_concurrentOperationQueue == nil)
            {
                _concurrentOperationQueue = [[NSOperationQueue alloc] init];
                _concurrentOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
                _concurrentOperationQueue.name = @"NCLNetworkingConcurrentOperationQueue";
            }
            
        }
    }
    
    return _concurrentOperationQueue;
}

#pragma mark - maintain "reference count" for http activity

- (void)applicationWillResignActive
{
    DEBUGLog(@"resetting http request count to 0");
    
    @synchronized(self)
    {
        self.activityCount = 0;
    }
}

- (void)incrementActivityCount
{
    @synchronized(self)
    {
        self.activityCount = self.activityCount +=1;
    }
}

- (void)decrementActivityCount
{
    @synchronized(self)
    {
        self.activityCount = MAX(self.activityCount-1, 0);
    }
}

- (void)setActivityCount:(NSInteger)activityCount
{
    @synchronized(self)
    {
		_activityCount = activityCount;
	}
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateNetworkActivityIndicatorVisibilityDelayed];
    });
}

- (BOOL)shouldShowNetworkActivityIndicator
{
    return (self.activityCount > 0);
}

- (void)updateNetworkActivityIndicatorVisibility
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:[self shouldShowNetworkActivityIndicator]];
}

- (void)updateNetworkActivityIndicatorVisibilityDelayed
{
    static NSTimeInterval const NETWORK_ACTIVITY_INVISIBILITY_DELAY = 0.2;

    // Delay hiding of activity indicator for a short interval, to avoid flickering
    if (![self shouldShowNetworkActivityIndicator])
    {
        [self.activityIndicatorVisibilityTimer invalidate];
        self.activityIndicatorVisibilityTimer = [NSTimer timerWithTimeInterval:NETWORK_ACTIVITY_INVISIBILITY_DELAY
                                                                        target:self
                                                                      selector:@selector(updateNetworkActivityIndicatorVisibility)
                                                                      userInfo:nil
                                                                       repeats:NO];
        
        [[NSRunLoop mainRunLoop] addTimer:self.activityIndicatorVisibilityTimer forMode:NSRunLoopCommonModes];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(updateNetworkActivityIndicatorVisibility) withObject:nil waitUntilDone:NO modes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
}

#pragma mark - user/host webview authentication

- (void)enableWebViewAuthenticationForUser:(NSString*)user host:(NSString*)host
{
    // the WebView http requests won't be intercepted for hosts where this isn't set
    if (host != nil &&
        host.length > 0)
    {
        host = [NCLNetworking secondLevelDomainForHost:host];
        
        @synchronized(_authInfo)
        {
            if (_authInfo == nil)
                _authInfo = [[NSMutableDictionary alloc] init];
            
            if (user == nil)
            {
                INFOLog(@"disabling WebView authentication for host:%@", host);
                
                [_authInfo removeObjectForKey:host];
            }
            else
            {
                INFOLog(@"enabling WebView authentication for user:%@ host:%@", user, host);
                
                [_authInfo setObject:user forKey:host];
            }
        }
    }
}

- (NSString*)userForHost:(NSString*)host
{
    if (host)
    {
        host = [NCLNetworking secondLevelDomainForHost:host];
        
        if (host)
        {
            @synchronized(_authInfo)
            {
                return [_authInfo objectForKey:host];
            }
        }
    }

    return nil;
}

#pragma mark - global http header injection

- (NSDictionary*)appHeaders;
{
    if (_appHeaders == nil)
    {
        @synchronized(_appHeaders)
        {
            if (_appHeaders == nil)
            {
                _appHeaders = [[NSMutableDictionary alloc] init];
                [_appHeaders setObject:[UIDevice identifier] forKey:NETWORKING_HEADER_DEVICE_ID];
                [_appHeaders setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:NETWORKING_HEADER_APP_VERSION];
                [_appHeaders setObject:[[UIDevice currentDevice] systemVersion] forKey:NETWORKING_HEADER_OS_VERSION];
            }
        }
    }
    
    return _appHeaders;
}

- (NSMutableDictionary*)standardHeadersForDomain:(NSString*)domain;
{
    return [_standardHeaders objectForKey:[NCLNetworking secondLevelDomainForHost:domain]];
}

// used to inject standard http headers for all outgoing http requests to hosts with the specified top-level domain
- (void)setStandardHeaders:(NSDictionary*)standardHeaders forDomain:(NSString*)domain
{
    if (domain != nil &&
        domain.length > 0)
    {
        domain = [NCLNetworking secondLevelDomainForHost:domain];
        
        @synchronized(_standardHeaders)
        {
            if (_standardHeaders == nil)
                _standardHeaders = [[NSMutableDictionary alloc] init];
            
            if (standardHeaders == nil)
                [_standardHeaders removeObjectForKey:domain];
            else
                [_standardHeaders setObject:standardHeaders forKey:domain];
        }
        
        [[NCLSessionManager sharedInstance] reset];
    }
}

- (void)injectStandardHeadersForRequest:(NSMutableURLRequest*)urlRequest
{
    @synchronized(_standardHeaders)
    {
        if (urlRequest &&
            _standardHeaders)
        {
            for (NSString *domain in _standardHeaders)
            {
                if ([urlRequest.URL.host contains:domain])
                {
                    NSDictionary *headerDict = [_standardHeaders objectForKey:domain];
                    
                    if (headerDict)
                    {
                        for (NSString *headerKey in headerDict)
                        {
                            NSString *value = [NSString stringFromObject:[headerDict objectForKey:headerKey]];
                            
                            if (value.length > 0)
                            {
                                [urlRequest addValue:[headerDict objectForKey:headerKey] forHTTPHeaderField:headerKey];
                            }
                        }
                    }
                    
                    break;
                }
            }
        }
    }
}

#pragma mark - network status

- (Reachability*)reachability
{
    if (_reachability == nil)
    {
        @synchronized(self)
        {
            if (_reachability == nil)
                _reachability = [Reachability reachabilityForInternetConnection];
        }
    }
    
    return _reachability;
}

- (BOOL)hasDeadWifiConnection
{
    if ([UIDevice connectedWifiName] != nil)
    {
        NCLAnalyticsEvent *reachabilityCheck = [NCLAnalyticsEvent eventForComponent:@"network" action:@"reachability" value:@"google.com"];
        
        NSError *error = nil;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:7];
        [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        [reachabilityCheck setError:error];
        [NCLAnalytics addTimedEvent:reachabilityCheck];

        if (error &&
            error.code == NSURLErrorTimedOut)
        {
            INFOLog(@"device is connected to dead Wifi!");
            
            return YES;
        }
    }
    
    return NO;
}

- (NetworkStatus)networkStatus
{
    NetworkStatus currentStatus = [[self reachability] currentReachabilityStatus];
    
    if (currentStatus == ReachableViaWWAN)
        currentStatus = [[self reachability] connectionRequired] ? NotReachable : currentStatus;

    return currentStatus;
}

- (BOOL)hasInternetConnection
{
    return [self networkStatus] != NotReachable;
}

- (void)startNetworkStatusNotifier
{
    [[self reachability] startNotifier];
}

- (void)stopNetworkStatusNotifier
{
    [[self reachability] stopNotifier];
}

@end
