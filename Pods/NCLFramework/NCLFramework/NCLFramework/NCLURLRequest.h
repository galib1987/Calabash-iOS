//
//  NCLURLRequest.h
//  NCLFramework
//
//  Created by Chad Long on 7/17/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ContentTypeAny = 0,
    ContentTypeJSON,
    ContentTypeXML,
    ContentTypeImage,
} ContentType;

typedef enum
{
    ThreadPriorityBackground = 0,
    ThreadPriorityDefault
} ThreadPriority;

@class NCLSimulatedHTTPResponse;

@interface NCLURLRequest : NSMutableURLRequest

@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic) ThreadPriority threadPriority;
@property BOOL shouldSuspendWhenBackgrounded;
@property BOOL shouldUseSerialDispatchQueue;
@property BOOL shouldPresentAlertOnError;
@property BOOL shouldSuppressAnalytics;
@property BOOL shouldDisplayActivityIndicator;
@property BOOL shouldOutputTraceLog;
@property (nonatomic, strong) NSObject *param;
@property (nonatomic, strong) NSString *notificationName;
@property (nonatomic, strong) NSString *notificationNameOnSuccess;
@property (nonatomic, strong) NSString *notificationNameOnFailure;
@property (nonatomic, strong) NSObject *notificationID;
@property (nonatomic) ContentType contentType;
@property (nonatomic, strong) NCLSimulatedHTTPResponse *simulatedHTTPResponse;

- (id)initWithScheme:(NSString*)scheme host:(NSString*)host port:(NSInteger)port path:(NSString*)urlPath;
- (BOOL)setHeadersAndBodyWithData:(id)data httpMethod:(NSString*)method;
- (id)mutableCopy;
- (NSString*)host;
- (NSInteger)port;


@end