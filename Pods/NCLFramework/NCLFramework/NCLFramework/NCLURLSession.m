//
//  NCLURLSession.m
//  NCLFramework
//
//  Created by Chad Long on 6/24/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import "NCLURLSession.h"
#import "NCLFramework.h"
#import "NCLNetworking_Private.h"
#import "NCLURLSessionHandler.h"
#import "NCLHTTPProtocol.h"

@interface NCLURLSession()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation NCLURLSession

+ (NCLURLSession*)sessionWithConfiguration:(NSURLSessionConfiguration*)configuration username:(NSString*)username delegateQueue:(NSOperationQueue*)queue
{
    NCLURLSessionHandler *handler = [[NCLURLSessionHandler alloc] init];
    handler.username = username;
    
    NCLURLSession *urlSession = [[NCLURLSession alloc] init];
    urlSession.session = [NSURLSession sessionWithConfiguration:configuration delegate:handler delegateQueue:queue];
    
    return urlSession;
}

- (NSURLSessionConfiguration *)configuration
{
    return self.session.configuration;
}

- (NSString*)username
{
    return ((NCLURLSessionHandler*)self.session.delegate).username;
}

- (NSData*)executeDataTaskWithRequest:(NSURLRequest*)request
                    returningResponse:(NSHTTPURLResponse**)response
                                error:(NSError**)error
{
    INFOLog(@"sending http %@ request to: %@", request.HTTPMethod, [request description]);
    DEBUGLog(@"headers: %@%@", self.session.configuration.HTTPAdditionalHeaders, [request allHTTPHeaderFields]);
    
    if (![request isMemberOfClass:[NCLURLRequest class]] ||
        ((NCLURLRequest*)request).shouldDisplayActivityIndicator == YES)
    {
        [[NCLNetworking sharedInstance] incrementActivityCount];
    }
    
    // synchronously execute task using a semaphore
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSData *data = nil;
    
    NSURLSessionDataTask *task =
    [self.session dataTaskWithRequest:request completionHandler:^(NSData *taskData, NSURLResponse *taskResponse, NSError *taskError)
     {
         BOOL shouldOutputTraceLog = [request isMemberOfClass:[NCLURLRequest class]] ? ((NCLURLRequest*)request).shouldOutputTraceLog : NO;
         
         id client = [NSURLProtocol propertyForKey:protocolClientKey inRequest:request];
         NSURLProtocol *protocol = [NSURLProtocol propertyForKey:protocolKey inRequest:request];
         
         // handle http response
         if (taskResponse)
         {
             if (response != 0)
                 *response = (NSHTTPURLResponse*)taskResponse;
             
             INFOLog(@"http response code = %d", ((NSHTTPURLResponse*)taskResponse).statusCode);
             
             if ([NCLFramework logLevel] > LogLevelINFO || shouldOutputTraceLog)
             {
                 INFOLog(@"http response MIME type = %@", taskResponse.MIMEType);
                 INFOLog(@"http response headers: %@", ((NSHTTPURLResponse*)taskResponse).allHeaderFields);
             }

             if (client &&
                 protocol)
             {
                 [client URLProtocol:protocol didReceiveResponse:taskResponse cacheStoragePolicy:NSURLCacheStorageAllowedInMemoryOnly];
             }
         }
         
         // handle http data
         data = taskData;
         
         // handle completion
         if (taskError)
         {
             INFOLog(@"ERROR occurred for http request: %@; error:%@", [request description], [taskError localizedDescription]);
             
             if (error != 0)
                 *error = taskError;
         }
         else if ([NCLFramework logLevel] > 1)
         {
             if (taskResponse &&
                 [taskResponse.MIMEType contains:@"image"])
             {
                 INFOLog(@"http image response: < %d K >", (taskData.length / 1024));
             }
             else
             {
                 NSInteger maxDisplayBytes = ([NCLFramework logLevel] > LogLevelINFO || shouldOutputTraceLog) ? 1024*1000 : 1024;
                 
                 INFOLog(@"http response data:\n%@", [taskData readableStringWithMaxBytes:maxDisplayBytes]);
             }
         }
         
         // webview callback (if required)
         if (client &&
             protocol)
         {
             [client URLProtocol:protocol didLoadData:taskData];
             
             if (taskError)
             {
                 DEBUGLog(@"protocol client URL load failed... %@", request.URL.description);
                 
                 [client URLProtocol:protocol didFailWithError:taskError];
             }
             else
             {
                 DEBUGLog(@"protocol client URL load completed successfully... %@", request.URL.description);
                 
                 [client URLProtocolDidFinishLoading:protocol];
             }
         }
         
         dispatch_semaphore_signal(semaphore);
     }];
    
    [task resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    if (![request isMemberOfClass:[NCLURLRequest class]] ||
        ((NCLURLRequest*)request).shouldDisplayActivityIndicator == YES)
    {
        [[NCLNetworking sharedInstance] decrementActivityCount];
    }
    
    return data;
}

- (NSURLSessionDownloadTask*)downloadTaskWithRequest:(NSURLRequest*)request completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler
{
    return [self.session downloadTaskWithRequest:request completionHandler:completionHandler];
}

- (NSURLSessionDownloadTask*)downloadTaskWithResumeData:(NSData*)resumeData completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler
{
    return [self.session downloadTaskWithResumeData:resumeData completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler
{
    return [self.session uploadTaskWithRequest:request fromFile:fileURL completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler
{
    return [self.session uploadTaskWithRequest:request fromData:bodyData completionHandler:completionHandler];
}

- (void)finishTasksAndInvalidate
{
    [self.session finishTasksAndInvalidate];
}

- (void)invalidateAndCancel
{
    [self.session invalidateAndCancel];
}

- (void)resetWithCompletionHandler:(void (^)(void))completionHandler
{
    [self.session resetWithCompletionHandler:completionHandler];
}

@end
