//
//  NCLKeychainStorage.m
//  NCLFramework
//
//  Created by Chad Long on 10/17/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import "NCLKeychainStorage.h"
#import "NCLFramework.h"
#import "NCLClientCertificate.h"
#import "NCLUserPassword.h"
#import "NCLNetworking_Private.h"
#import "NSError+Utility.h"

@interface NCLKeychainStorage()

+ (NSString*)identityKeyForHost:(NSString*)host;
- (void)cacheCertificateForIdentity:(SecIdentityRef)identity host:(NSString*)host;

@property (nonatomic, strong) NSMutableDictionary *certificateCache;

@end

@implementation NCLKeychainStorage

#pragma mark - user/password management

+ (NCLKeychainStorage*)sharedInstance
{
	static dispatch_once_t pred;
	static NCLKeychainStorage *sharedInstance = nil;
    
	dispatch_once(&pred, ^
    {
        sharedInstance = [[self alloc] init];
    });
	
    return sharedInstance;
}

+ (NSMutableDictionary*)keychainQueryForHost:(NSString*)host
{
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
	[query setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
	[query setObject:[NCLNetworking secondLevelDomainForHost:host] forKey:(__bridge id)kSecAttrService];
    [query setObject:(__bridge id)kSecAttrAccessibleWhenUnlocked forKey:(__bridge id)kSecAttrAccessible];
    
    return query;
}

+ (NSDictionary*)keychainValuesForHost:(NSString*)host
{
    // setup the keychain query to return data
    NSMutableDictionary *query = [self keychainQueryForHost:host];
	[query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnAttributes];
	[query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    // convert the keychain query to core foundation classes, and retrieve the keychain values
    CFDictionaryRef cfQuery = (__bridge_retained CFDictionaryRef)query;
	CFDictionaryRef cfResult = NULL;
    OSStatus status = SecItemCopyMatching(cfQuery, (CFTypeRef*)&cfResult);
    CFRelease(cfQuery);
    
    NSDictionary *result = nil;
    
	if (status == errSecSuccess)
    {
        result = (__bridge_transfer NSDictionary*)cfResult;
    }
    
    return result;
}

+ (BOOL)saveUserPassword:(NCLUserPassword*)userPass error:(NSError**)error
{
    // if nothing is provided, ignore the call
    if (userPass == nil ||
        userPass.username == nil ||
        userPass.username.length == 0 ||
        userPass.host == nil ||
        userPass.host.length == 0)
    {
        DEBUGLog(@"nothing to save to keychain... continuing");
        
        return YES;
    }
    
    // clean up the parameter data
    userPass.username = [userPass.username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (userPass.password == nil)
    {
        userPass.password = @"";
    }
    
    // clear existing storage
    OSStatus status = errSecSuccess;
    NSMutableDictionary *query = [self keychainQueryForHost:userPass.host];
    NSString *keychainUsername = [query objectForKey:(__bridge id)kSecAttrAccount];
    
    SecItemDelete((__bridge CFDictionaryRef)query);
    
    // save the credentials to the keychain
    [query setObject:(id)userPass.username forKey:(__bridge id)kSecAttrAccount];
    [query setObject:(id)[userPass.password dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
    
    status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    
    if (status != errSecSuccess)
    {
        NSError *saveError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:[[NSString stringWithFormat:@"%ld", status] integerValue]
                                          description:@"Error Saving User/Password"
                                        failureReason:[NSString stringWithFormat:@"%ld", status]];
        
        if (error != 0)
        {
            *error = saveError;
        }
        
        INFOLog(@"error adding user/password to keychain: %ld", status);
        [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"keychain" action:@"save" value:userPass.username error:saveError]];
        
        return NO;
    }
    
    // reset URL sessions
    [[NCLSessionManager sharedInstance] reset];
    
    INFOLog(@"saved user/password to keychain for user: %@", userPass.username);
    
    if (![keychainUsername isEqualToString:userPass.username])
        [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"keychain" action:@"save" value:userPass.username]];
    
    return YES;
}

+ (NCLUserPassword*)userPasswordForUser:(NSString*)username host:(NSString*)host
{
    if (username != nil &&
        username.length > 0 &&
        host != nil &&
        host.length > 0)
    {
        NSDictionary *keychainValues = [self keychainValuesForHost:host];
        
        if (keychainValues != nil)
        {
            NSString *keychainUsername = [keychainValues objectForKey:(__bridge id)kSecAttrAccount];
            NSString *keychainPassword = [[NSString alloc] initWithData:[keychainValues objectForKey:(__bridge id)kSecValueData] encoding:NSUTF8StringEncoding];
            
            username = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ([username isEqualToString:keychainUsername])
            {
                NSString *secondLevelDomainName = [NCLNetworking secondLevelDomainForHost:host];
                
                return [[NCLUserPassword alloc] initWithUsername:keychainUsername password:keychainPassword host:secondLevelDomainName];
            }
        }
    }
    
    DEBUGLog(@"user %@ not in keychain for host %@", username, [NCLNetworking secondLevelDomainForHost:host]);
    
    return nil;
}

+ (BOOL)clearGenericPasswordKeysForHost:(NSString*)host
{
    if (host == nil)
        return NO;
    
    NSMutableDictionary *query = [NCLKeychainStorage keychainQueryForHost:host];
    OSStatus delStatus = SecItemDelete((__bridge CFDictionaryRef)query);
    
    if (delStatus == errSecSuccess ||
        delStatus == errSecItemNotFound)
    {
        [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"keychain"
                                                             action:@"remove passwords"
                                                              value:[NCLNetworking secondLevelDomainForHost:host]
                                                              error:nil]];
        
        return YES;
    }
    else
    {
        NSError *removeError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                                   code:[[NSString stringWithFormat:@"%ld", delStatus] integerValue]
                                            description:[NCLNetworking secondLevelDomainForHost:host]
                                          failureReason:nil];
        
        [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"keychain"
                                                             action:@"remove passwords"
                                                              value:removeError.description
                                                              error:removeError]];
        
        INFOLog(@"error removing identity from keychain: %ld", delStatus);
        
        return NO;
    }
}

#pragma mark - client certificate management

+ (NCLClientCertificate*)certificateForHost:(NSString*)host
{
    return [[NCLKeychainStorage sharedInstance] certificateForHost:host];
}

- (NCLClientCertificate*)certificateForHost:(NSString*)host
{
    if (host == nil)
        return nil;
    
    NCLClientCertificate *cert = nil;
    host = [NCLNetworking secondLevelDomainForHost:host];
    
    // first priority is to use the cert from memory
    @synchronized(self)
    {
        if (_certificateCache)
        {
            cert = [_certificateCache objectForKey:host];
        }
        
        // if no cert is in memory, get it from the keychain & cache it in memory
        if (cert == nil)
        {
            NSString *identityKey = [NCLKeychainStorage identityKeyForHost:host];
            CFDataRef identityRef = (__bridge CFDataRef)[[NSUserDefaults standardUserDefaults] dataForKey:identityKey];
            
            if (identityRef != nil)
            {
                CFTypeRef identity_ref = NULL;
                const void *keys[] =   { kSecReturnRef,  kSecValuePersistentRef };
                const void *values[] = { kCFBooleanTrue, identityRef };
                CFDictionaryRef dict = CFDictionaryCreate(NULL, keys, values, 2, NULL, NULL);
                SecItemCopyMatching(dict, &identity_ref);
                
                if (dict)
                    CFRelease(dict);
                
                cert = [[NCLClientCertificate alloc] initWithIdentity:(SecIdentityRef)identity_ref host:host];
                
                INFOLog(@"successfully retrieved client certificate from keychain");
                
                [self cacheCertificateForIdentity:(SecIdentityRef)identity_ref host:host];
            }
        }
    }

    return cert;
}

- (void)cacheCertificateForIdentity:(SecIdentityRef)identity host:(NSString*)host
{
    // caches a certificate in memory for the identity/host
    // this provides a smoother user experience in the case that a client certificate is not yet stored in the keychain
    if (_certificateCache == nil)
    {
        _certificateCache = [[NSMutableDictionary alloc] init];
    }
    
    host = [NCLNetworking secondLevelDomainForHost:host];
    NCLClientCertificate *cert = [[NCLClientCertificate alloc] initWithIdentity:identity host:host];
    [_certificateCache setObject:cert forKey:host];
    
    INFOLog(@"successfully stored client certificate in memory");
}

+ (NSString*)identityKeyForHost:(NSString*)host
{
    return [NSString stringWithFormat:@"ClientCertIdentityRef-%@", [NCLNetworking secondLevelDomainForHost:host]];
}

+ (BOOL)saveIdentity:(SecIdentityRef)identity forHost:(NSString*)host error:(NSError**)error
{
    if (identity == nil ||
        host == nil)
    {
        return NO;
    }
    
    @synchronized(self)
    {
        // clean the certificate from the keychain
        [NCLKeychainStorage clearCertificateForHost:host];
        
        // cache the identity in memory
        [[NCLKeychainStorage sharedInstance] cacheCertificateForIdentity:identity host:host];
        
        // get a standardized key to store the identity reference to the keychain in UserDefaults
        NSString *identityKey = [NCLKeychainStorage identityKeyForHost:host];
        
        // add the client certificate identity (includes the certificate and private key) to the keychain
        CFDataRef persistentRef = nil;
        NSDictionary *addAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                       (__bridge id)identity, kSecValueRef,
                                       (id)kCFBooleanTrue, kSecReturnPersistentRef,
                                       nil];
        OSStatus addStatus = SecItemAdd((__bridge CFDictionaryRef)addAttributes, (CFTypeRef *)&persistentRef);
        
        if (addStatus != errSecSuccess)
        {
            NSError *addError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                                    code:[[NSString stringWithFormat:@"%ld", addStatus] integerValue]
                                             description:@"error saving identity to keychain"
                                           failureReason:nil];
            
            if (error != 0)
            {
                *error = addError;
            }
            
            INFOLog(@"error adding identity to keychain: %ld", addStatus);
            [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"keychain" action:@"save certificate" value:identityKey error:addError]];
            
            return NO;
        }
        
        // if no errors, store a reference to the keychain for the identity in user defaults
        [[NSUserDefaults standardUserDefaults] setObject:(__bridge_transfer NSData*)persistentRef forKey:identityKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // reset URL sessions
        [[NCLSessionManager sharedInstance] reset];
        
        INFOLog(@"saved identity to keychain for key: %@", identityKey);
        [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"keychain" action:@"save certificate" value:identityKey]];
    }
    
    return YES;
}

+ (BOOL)clearCertificateForHost:(NSString*)host
{
    @synchronized(self)
    {
        NSError *removeError = nil;
        NSString *identityKey = [NCLKeychainStorage identityKeyForHost:host];
        CFDataRef identityRef = (__bridge CFDataRef)[[NSUserDefaults standardUserDefaults] dataForKey:identityKey];
        
        if (identityRef)
        {
            const void *keys[] =   { kSecValuePersistentRef };
            const void *values[] = { identityRef };
            CFDictionaryRef dict = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
            
            OSStatus delStatus = SecItemDelete(dict);
            NSInteger delStatusInteger = [[NSString stringWithFormat:@"%ld", delStatus] integerValue];
            
            if (delStatus == errSecSuccess ||
                delStatus == errSecItemNotFound)
            {
                [NCLKeychainStorage sharedInstance].certificateCache = nil;
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:identityKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                INFOLog(@"removed existing identity from keychain for key: %@", identityKey);
            }
            else
            {
                removeError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                                  code:delStatusInteger
                                           description:@"error removing certificate"
                                         failureReason:nil];
                
                INFOLog(@"error removing identity from keychain: %ld", delStatus);
            }
            
            [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"keychain"
                                                                 action:@"remove certificate"
                                                                  value:[NSString stringWithFormat:@"%d:%@", delStatusInteger, [NCLNetworking secondLevelDomainForHost:host]]
                                                                  error:removeError]];
        }
        
        // reset URL sessions
        [[NCLSessionManager sharedInstance] reset];
        
        return removeError == nil ? YES : NO;
    }
}

+ (NSArray*)keychainItems
{
    NSMutableArray *items = [NSMutableArray new];
    
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  (__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnAttributes,
                                  (__bridge id)kSecMatchLimitAll, (__bridge id)kSecMatchLimit,
                                  nil];
    
    NSArray *secItemClasses = [NSArray arrayWithObjects:
                               (__bridge id)kSecClassGenericPassword,
                               (__bridge id)kSecClassInternetPassword,
                               (__bridge id)kSecClassCertificate,
//                               (__bridge id)kSecClassKey,
                               (__bridge id)kSecClassIdentity,
                               nil];
    
    for (id secItemClass in secItemClasses)
    {
        [query setObject:secItemClass forKey:(__bridge id)kSecClass];
        CFTypeRef result = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        
        [items addObject:[NSString stringWithFormat:@"%@", (__bridge id)result]];
        
        if (result != NULL)
            CFRelease(result);
    }

    return items;
}

//- (NSError*)deleteAllKeysForSecClass:(CFTypeRef)secClass
//{
//    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
//    [dict setObject:(__bridge id)secClass forKey:(__bridge id)kSecClass];
//    OSStatus status = SecItemDelete((__bridge CFDictionaryRef) dict);
//    
//    if (status == errSecSuccess ||
//        status == errSecItemNotFound)
//    {
//        return nil;
//    }
//    else
//    {
//        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain
//                                             code:[[NSString stringWithFormat:@"%ld", status] integerValue]
//                                      description:[NSString stringWithFormat:@" %ld", status]
//                                    failureReason:nil];
//        
//        [NCLAnalytics addEvent:[NCLAnalyticsEvent eventForComponent:@"keychain"
//                                                             action:@"clear"
//                                                              value:@"failed"
//                                                              error:error]];
//        
//        return error;
//    }
//}

@end