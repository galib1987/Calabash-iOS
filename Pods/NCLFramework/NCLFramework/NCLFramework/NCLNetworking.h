//
//  NCLNetworking.h
//  NCLFramework
//
//  Created by Chad Long on 1/4/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NCLNetworking : NSObject

@property (nonatomic, readonly) NetworkStatus networkStatus;
@property (readonly, strong, nonatomic) NSOperationQueue *serialOperationQueue;
@property (readonly, strong, nonatomic) NSOperationQueue *concurrentOperationQueue;

+ (NCLNetworking*)sharedInstance;

+ (NSError*)HTTPErrorForCode:(NSInteger)code;
+ (NSError*)HTTPErrorForData:(NSData*)data response:(NSHTTPURLResponse*)response error:(NSError*)error;

- (BOOL)hasInternetConnection;
- (BOOL)hasDeadWifiConnection;
- (void)startNetworkStatusNotifier;
- (void)stopNetworkStatusNotifier;

- (void)enableWebViewAuthenticationForUser:(NSString*)user host:(NSString*)host;

- (NSDictionary*)appHeaders;
- (NSMutableDictionary*)standardHeadersForDomain:(NSString*)domain;
- (void)setStandardHeaders:(NSDictionary*)standardHeaders forDomain:(NSString*)domain;

@end
