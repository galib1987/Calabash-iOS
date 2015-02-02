//
//  NCLURLRequest.m
//  NCLFramework
//
//  Created by Chad Long on 7/17/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import "NCLFramework.h"
#import "NCLURLRequest.h"
#import "UIDevice+Utility.h"
#import "NCLSimulatedHTTPResponse.h"

@implementation NCLURLRequest

@synthesize parameters = _parameters;

#pragma mark - Initialization

+ (id)requestWithURL:(NSURL *)URL
{
    return [[NCLURLRequest alloc] initWithURL:URL];
}

- (id)initWithURL:(NSURL*)theURL
{
    return [self initWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];
}

+ (id)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval
{
    return [[NCLURLRequest alloc] initWithURL:URL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
}

- (id)initWithURL:(NSURL*)theURL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval
{
    self = [super initWithURL:theURL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    
    if (self)
    {
        self.shouldUseSerialDispatchQueue = NO;
        self.threadPriority = ThreadPriorityDefault;
        self.shouldPresentAlertOnError = NO;
        self.shouldSuppressAnalytics = NO;
        self.shouldSuspendWhenBackgrounded = NO;
        self.shouldDisplayActivityIndicator = YES;
        self.shouldOutputTraceLog = NO;
        self.contentType = ContentTypeJSON;
//        self.expectedResponseType = ContentTypeJSON;
        [self setHTTPShouldHandleCookies:NO];
    }
    
    return self;
}

- (id)initWithScheme:(NSString*)scheme host:(NSString*)host port:(NSInteger)port path:(NSString*)urlPath
{
    self = [self init];
    
    if (self)
    {
        [self setURL:[self urlForScheme:scheme host:host port:port path:urlPath queryParams:nil]];
        [self setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
        [self setTimeoutInterval:30.0];
        self.shouldUseSerialDispatchQueue = NO;
        self.threadPriority = ThreadPriorityDefault;
        self.shouldPresentAlertOnError = NO;
        self.shouldSuppressAnalytics = NO;
        self.shouldSuspendWhenBackgrounded = NO;
        self.shouldDisplayActivityIndicator = YES;
        self.shouldOutputTraceLog = NO;
        self.contentType = ContentTypeJSON;
//        self.expectedResponseType = ContentTypeJSON;
        [self setHTTPShouldHandleCookies:NO];
    }

    return self;
}

#pragma mark - Convenience methods

- (NSURL*)urlForScheme:(NSString*)scheme host:(NSString*)host port:(NSInteger)port path:(NSString*)urlPath queryParams:(NSDictionary*)queryParams
{
    NSString *portString = (port != 0) ? [NSString stringWithFormat:@":%i", port] : @"";
    NSString *queryParamsString = [self stringForQueryParams:queryParams];
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@%@%@%@", scheme, host, portString, urlPath, queryParamsString]];
}

- (void)setParameters:(NSDictionary*)parameters
{
    NSURL *url = [self urlForScheme:self.URL.scheme host:self.host port:self.port path:self.URL.path queryParams:parameters];
    [self setURL:url];
    
    _parameters = parameters;
}

- (BOOL)setHeadersAndBodyWithData:(id)data httpMethod:(NSString*)method
{
    BOOL success = YES;
    
    if (data == nil)
    {
        data = @[];
    }
    
    [self setHTTPMethod:method];
    
    // JSON
    if (self.contentType == ContentTypeJSON)
    {
        if (![data isKindOfClass:[NSDictionary class]] && ![data isKindOfClass:[NSArray class]])
            INFOLog(@"EXPECTING NSDictionary OR NSArray OBJECT FOR JSON HTTP BODY");
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
        
        if (error)
        {
            success = NO;
            
            if ([NCLFramework logLevel] > 1)
            {
                NSString *printableData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                INFOLog(@"JSON serialization error: %@\n%@", [error localizedDescription], printableData);
            }
        }
        else
        {
            [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [self setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
            [self setHTTPBody:jsonData];
            
            if ([NCLFramework logLevel] > 1)
            {
                NSInteger maxDisplayBytes = ([NCLFramework logLevel] > LogLevelINFO || self.shouldOutputTraceLog) ? 1024*1000 : 1024;
                NSError *parseError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&parseError];
                
                if (json)
                {
                    NSString *prettyPrintJSON = [json description];
//                    NSString *moreBytes = prettyPrintJSON.length > maxDisplayBytes ? [NSString stringWithFormat:@"... < %i MORE BYTES >", prettyPrintJSON.length - maxDisplayBytes] : @"";
//                    prettyPrintJSON = prettyPrintJSON.length > maxDisplayBytes ? [prettyPrintJSON substringToIndex:maxDisplayBytes] : prettyPrintJSON;
                    
                    INFOLog(@"JSON payload:\n@", prettyPrintJSON);
                }
            }
        }
    }
    // image
    else if (self.contentType == ContentTypeImage)
    {
        if (![data isKindOfClass:[NSData class]])
            INFOLog(@"EXPECTING NSData OBJECT FOR IMAGE HTTP BODY");
        
        [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [self setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
        [self setHTTPBody:data];
        
        INFOLog(@"image payload: < %d K >", ([data length] / 1024));
    }
    // XML
    else if (self.contentType == ContentTypeXML)
    {
        if (![data isKindOfClass:[NSData class]])
            INFOLog(@"EXPECTING NSData OBJECT FOR XML HTTP BODY");
        
        [self setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
        [self setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
        [self setHTTPBody:data];
        
        INFOLog(@"XML payload: < %d K >", ([data length] / 1024));
    }
    
    return success;
}

- (NSString*)host
{
    return self.URL.host;
}

- (NSInteger)port
{
    if (self.URL.port == nil)
        return 0;
    else
        return [self.URL.port integerValue];
}

#pragma mark - Description & copying

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@://%@%@%@%@",
            self.URL.scheme, self.host, self.port == 0 ? @"" : [NSString stringWithFormat:@":%i", self.port], self.URL.path, [self stringForQueryParams:self.parameters]];
}

- (id)mutableCopy
{
    NCLURLRequest *urlRequest = [[NCLURLRequest alloc] initWithURL:self.URL cachePolicy:self.cachePolicy timeoutInterval:self.timeoutInterval];
    urlRequest.parameters = self.parameters;
    [urlRequest setAllHTTPHeaderFields:self.allHTTPHeaderFields];
    urlRequest.HTTPShouldHandleCookies = self.HTTPShouldHandleCookies;
    urlRequest.HTTPMethod = self.HTTPMethod;
    urlRequest.HTTPBody = self.HTTPBody;
    urlRequest.parameters = self.parameters;
    urlRequest.param = self.param;
    urlRequest.shouldUseSerialDispatchQueue = self.shouldUseSerialDispatchQueue;
    urlRequest.shouldPresentAlertOnError = self.shouldPresentAlertOnError;
    urlRequest.shouldSuppressAnalytics = self.shouldSuppressAnalytics;
    urlRequest.shouldSuspendWhenBackgrounded = self.shouldSuspendWhenBackgrounded;
    urlRequest.shouldDisplayActivityIndicator = self.shouldDisplayActivityIndicator;
    urlRequest.notificationName = self.notificationName;
    urlRequest.notificationNameOnSuccess = self.notificationNameOnSuccess;
    urlRequest.notificationNameOnFailure = self.notificationNameOnFailure;
    urlRequest.notificationID = self.notificationID;
    urlRequest.shouldOutputTraceLog = self.shouldOutputTraceLog;
    urlRequest.contentType = self.contentType;
//    urlRequest.expectedResponseType = self.expectedResponseType;
    urlRequest.threadPriority = self.threadPriority;
    
    urlRequest.simulatedHTTPResponse = self.simulatedHTTPResponse;
    
    return urlRequest;
}

#pragma mark - Query string encoding

- (NSString*)stringForQueryParams:(NSDictionary*)queryParams
{
    NSString *queryParamsString = @"";
    
    if (queryParams != nil &&
        queryParams.count > 0)
    {
        queryParamsString = [NSString stringWithFormat:@"?%@", [self stringWithURLEncodedComponentsForDictionary:queryParams]];
    }
    
    return queryParamsString;
}

- (BOOL)formatValue:(NSObject *)object forKey:(NSString *)key arguments:(NSMutableArray *)arguments
{
    BOOL handled = YES;
    
    // clean up strings with proper escaping
    if ([object isKindOfClass:[NSString class]])
    {
        [arguments addObject:[NSString stringWithFormat:@"%@=%@", key, [self stringByEscapingForURLQueryString:(NSString*)object]]];
    }
    
    // numbers
    else if ([object isKindOfClass:[NSNumber class]])
    {
        [arguments addObject:[NSString stringWithFormat:@"%@=%@", key, [(NSNumber*)object stringValue]]];
    }
    
    // format dates/times in ISO 8601
    else if ([object isKindOfClass:[NSDate class]])
    {
        [arguments addObject:[NSString stringWithFormat:@"%@=%@", key, [(NSDate*)object description]]];
    } else {
        handled = NO;
    }
    
    return handled;
}

- (NSString*)stringWithURLEncodedComponentsForDictionary:(NSDictionary*)dictionary
{
    NSMutableArray *arguments = [NSMutableArray array];
    
    for (NSString *key in dictionary)
    {
        NSObject *object = [dictionary objectForKey:key];
        
        BOOL handled = [self formatValue:object forKey:key arguments:arguments];
        
        if (!handled && [object isKindOfClass:[NSArray class]])
        {
            NSArray *values = (NSArray *)object;
            for (NSObject *value in values) {
                [self formatValue:value forKey:key arguments:arguments];
            }
        }
    }
    
    return [arguments componentsJoinedByString:@"&"];
}

- (NSString*)stringByEscapingForURLQueryString:(NSString*)queryString
{
    NSString *result = queryString;
    
    CFStringRef originalAsCFString = (__bridge CFStringRef)queryString;
    CFStringRef leaveAlone = CFSTR(" ");
    CFStringRef toEscape = CFSTR("\n\r?[]()$,!'*;:@&=#%+/");
    
    CFStringRef escapedStr;
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, originalAsCFString, leaveAlone, toEscape, kCFStringEncodingUTF8);
    
    if (escapedStr)
    {
        NSMutableString *mutable = [NSMutableString stringWithString:(__bridge NSString*)escapedStr];
        CFRelease(escapedStr);
        
        [mutable replaceOccurrencesOfString:@" " withString:@"+" options:0 range:NSMakeRange(0, [mutable length])];
        result = mutable;
    }
    
    return result;
}

@end
