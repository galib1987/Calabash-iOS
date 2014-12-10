//
//  NNNUserDefaultsManager.m
//  OAuthSample
//
//  Created by Ryan Smith on 10/14/14.
//  Copyright 2014 NetJets. All rights reserved.
//

#import "NNNUserDefaultsManager.h"

NSString * const NJCTSettingUsername = @"Username";
NSString * const NJCTSettingHost = @"Host";
NSString * const NJCTSettingPort = @"Port";
NSString * const NJCTSettingSecure = @"Secure";
NSString * const NJCTSettingTimeout = @"Timeout";

@interface NNNUserDefaultsManager ()

@end



@implementation NNNUserDefaultsManager

+ (NNNUserDefaultsManager*)sharedInstance 
{
	__strong static NNNUserDefaultsManager *_sharedObject = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		_sharedObject = [[super allocWithZone:nil] init];
		});
	return _sharedObject;
}

- (NSString*)activeUsername
{
    NSString *activeUsername = self.username;
    
    if (activeUsername &&
        activeUsername.length == 0)
    {
        activeUsername = nil;
    }
    
    return activeUsername;
}

- (NSString *)username
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:NJCTSettingUsername];
}

- (void)setUsername:(NSString *)username
{
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:NJCTSettingUsername];
    [self synchronize];
}

- (void)clearUsername
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NJCTSettingUsername];
    [self synchronize];
}

- (NSString *)host
{
    NSString *host = [[NSUserDefaults standardUserDefaults] valueForKey:NJCTSettingHost];
    if (!host)
    {
        host = @"servicesdev.netjets.com";
        [self setHost:host];
    }
    
    return host;
}

- (void)setHost:(NSString *)host
{
    [[NSUserDefaults standardUserDefaults] setValue:host forKey:NJCTSettingHost];
    [self synchronize];
}

- (NSInteger)port
{
    NSNumber *port = [[NSUserDefaults standardUserDefaults] valueForKey:NJCTSettingPort];
    if (!port)
    {
        port = @0;
        [self setPort:port.integerValue];
    }
    
    return port.integerValue;
}

- (void)setPort:(NSInteger)port
{
    [[NSUserDefaults standardUserDefaults] setValue:@(port) forKeyPath:NJCTSettingPort];
    [self synchronize];
}

- (BOOL)isSecure
{
    NSNumber *secure = [[NSUserDefaults standardUserDefaults] valueForKey:NJCTSettingSecure];
    if (!secure)
    {
        secure = @YES;
        [self setSecure:secure.boolValue];
    }
    
    return secure.boolValue;
}

- (void)setSecure:(BOOL)secure
{
    [[NSUserDefaults standardUserDefaults] setValue:@(secure) forKeyPath:NJCTSettingSecure];
    [self synchronize];
}

- (NSNumber *)timeout
{
    NSNumber *timeout = [[NSUserDefaults standardUserDefaults] valueForKey:NJCTSettingTimeout];
    if (!timeout)
    {
        timeout = @30;
        [self setTimeout:timeout];
    }
    
    return timeout;
}

- (void)setTimeout:(NSNumber *)timeout
{
    [[NSUserDefaults standardUserDefaults] setValue:timeout forKeyPath:NJCTSettingTimeout];
    [self synchronize];
}

- (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
