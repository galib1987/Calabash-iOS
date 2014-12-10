//
//  NNNUserDefaultsManager.h
//  OAuthSample
//
//  Created by Ryan Smith on 10/14/14.
//  Copyright 2014 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const NJCTSettingUsername;

@interface NNNUserDefaultsManager : NSObject

+ (NNNUserDefaultsManager*)sharedInstance;

- (NSString *)username;
- (void)setUsername:(NSString *)username;
- (void)clearUsername;
- (NSString *)host;
- (void)setHost:(NSString *)host;
- (NSInteger)port;
- (void)setPort:(NSInteger)port;
- (BOOL)isSecure;
- (void)setSecure:(BOOL)secure;
- (NSNumber *)timeout;
- (void)setTimeout:(NSNumber *)timeout;

@end
