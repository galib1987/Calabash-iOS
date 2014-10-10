//
//  NCLRemoteDataService.h
//  FliteDeck
//
//  Created by Chad Long on 5/21/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NCLURLSession;
@class NCLURLRequest;

#define HTTP_REQUEST_ID_NOTIFICATION_KEY @"HTTPRequestIDNotificationKey"
#define HTTP_REQUEST_ERROR_NOTIFICATION_KEY @"HTTPRequestErrorNotificationKey"

@interface NCLHTTPClient : NSObject

/*
 * may be overridden by subclasses to switch between an http & https scheme (defaults to YES, or https)
 */
- (BOOL)isSecure;

/*
 * REQUIRED to be overridden by subclasses to provide a host for this http client
 */
- (NSString*)host;

/*
 * may be overridden by subclasses to provide a port for this http client (defaults to 80)
 */
- (NSInteger)port;

/*
 * may be overridden by subclasses to provide a base path for this http client
 */
- (NSString*)basePath;

/*
 * may be overridden by subclasses to provide a user when this http client is challenged for credentials
 * -see NCLKeychainStorage.saveUserPassword for information on persisting credentials in the keychain
 */
- (NSString*)user;

/*
 * gets a shared private URLSession for this http client, but should only be used when an NSURLSessionUploadTask or NSURLSessionDownloadTask are required
 * -the session returned is dynamic, and will reset if the user or host change
 * -the session handles all authentication challenges (see NCLKeychainStorage.saveUserPassword for information on persisting credentials)
 */
- (NCLURLSession*)session;

/*
 * gets a default URLRequest for this http client
 * properties & defaults...
 * -timeoutInterval = 30
 * -expectedResponseType = ContentTypeJSON            * generates error for unexpected responses, oftentimes caused by wifi redirects
 * -shouldDisplayActivityIndicator = YES              * if YES, displays the iOS activity indicator in the device status bar
 * -shouldPresentAlertOnError = NO                    * if YES, network & http errors are delegated to the NCLErrorDelegate (see NCLFramework.setErrorDelegate)
 * -shouldSuppressAnalytics = NO                      * if NO & the analytics engine has been started, all non-WebView network calls will be audited
 * -shouldSuspendWhenBackgrounded = NO                * if NO, all network calls with a timeout <60 will be finished if the app is backgrounded
 * -shouldUseSerialDispatchQueue = NO                 * if NO, network calls are processed on a concurrent operation queue
 * -(NSObject*)param                                  * allows passing of paramater(s) into the async completion block
 * -(NSString*)notificationName                       * when specified, sends this notification after sync call or async completionBlock has completed (always sent on the main thread)
 * -(NSString*)notificationNameOnSuccess              * when specified, sends this notification after sync call or async completionBlock has completed without error (always sent on the main thread)
 * -(NSString*)notificationNameOnFailure              * when specified, sends this notification after sync call or async completionBlock has completed with error (always sent on the main thread)
 * -(NSObject*)notificationID                         * allows the sending of an identifier in the notification payload (typically a unique key related to the request)
 * -(NCLSimulatedHTTPResponse*)simulatedHTTPResponse  * allows the simulation of this http request (see NCLSimulatedHTTPResponse)
 */
- (NCLURLRequest*)urlRequestWithPath:(NSString*)urlPath;

/*
 * synchronous http GET w/ request & query parameters
 * -see NCLURLRequest for customized request behavior
 * -parameters are key/value pairs to be serialized to a query string (NSString, NSNumber & NSDate serialization is supported), pass nil for no parameters
 */
- (NSData*)GET:(NCLURLRequest*)request parameters:(NSDictionary*)parameters returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error;

/*
 * asynchronous http GET w/ request & query parameters
 * -see NCLURLRequest properties for customized request behavior
 * -parameters are key/value pairs to be serialized to a query string (NSString, NSNumber & NSDate serialization is supported), pass nil for no parameters
 * -completionBlock is executed in a BACKGROUND THREAD
 */
- (void)GET:(NCLURLRequest*)request parameters:(NSDictionary*)parameters completionBlock:(void(^)(NSData*, NSError*))completionBlock;

/*
 * synchronous http POST w/ request & http body
 * -see NCLURLRequest for customized request behavior
 * -if http body is an array or dictionary, it will be sent as JSON w/ the proper headers (otherwise NSData objects are passed through)
 * -query parameters can still be set w/ request.parameters if needed
 */
- (NSData*)POST:(NCLURLRequest*)request HTTPBody:(id)data returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error;

/*
 * asynchronous http POST w/ request & http body
 * -see NCLURLRequest for customized request behavior
 * -if http body is an array or dictionary, it will be sent as JSON w/ the proper headers (otherwise NSData objects are passed through)
 * -completionBlock is executed in a BACKGROUND THREAD
 * -query parameters can still be set w/ request.parameters if needed
 */
- (void)POST:(NCLURLRequest*)request HTTPBody:(id)data completionBlock:(void(^)(NSData*, NSError*))completionBlock;

- (NSData*)PUT:(NCLURLRequest*)request HTTPBody:(id)data returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error;
- (void)PUT:(NCLURLRequest*)request HTTPBody:(id)data completionBlock:(void(^)(NSData*, NSError*))completionBlock;

- (NSData*)DELETE:(NCLURLRequest*)request HTTPBody:(id)data returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error;
- (void)DELETE:(NCLURLRequest*)request HTTPBody:(id)data completionBlock:(void(^)(NSData*, NSError*))completionBlock;

@end
