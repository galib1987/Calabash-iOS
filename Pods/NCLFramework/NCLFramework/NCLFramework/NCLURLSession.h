//
//  NCLURLSession.h
//  NCLFramework
//
//  Created by Chad Long on 6/24/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCLURLSession : NSObject

@property (nonatomic, strong, readonly) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong, readonly) NSString *username;

+ (NCLURLSession*)sessionWithConfiguration:(NSURLSessionConfiguration*)configuration username:(NSString*)username delegateQueue:(NSOperationQueue*)queue;

- (NSData*)executeDataTaskWithRequest:(NSURLRequest*)request
                    returningResponse:(NSHTTPURLResponse**)response
                                error:(NSError**)error;

- (NSURLSessionDownloadTask*)downloadTaskWithRequest:(NSURLRequest*)request completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;
- (NSURLSessionDownloadTask*)downloadTaskWithResumeData:(NSData*)resumeData completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;

- (NSURLSessionUploadTask*)uploadTaskWithRequest:(NSURLRequest*)request fromFile:(NSURL*)fileURL completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

- (void)finishTasksAndInvalidate;
- (void)invalidateAndCancel;
- (void)resetWithCompletionHandler:(void (^)(void))completionHandler;

@end
