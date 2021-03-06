//
//  NCLKeychainStorage.h
//  NCLFramework
//
//  Created by Chad Long on 10/17/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NCLUserPassword;
@class NCLClientCertificate;

@interface NCLKeychainStorage : NSObject

+ (NCLKeychainStorage*)sharedInstance;

+ (BOOL)saveUserPassword:(NCLUserPassword*)userPass error:(NSError**)error;
+ (NCLUserPassword*)userPasswordForUser:(NSString*)username host:(NSString*)host;
+ (BOOL)clearGenericPasswordKeysForHost:(NSString*)host;

+ (BOOL)saveIdentity:(SecIdentityRef)identity forHost:(NSString*)host error:(NSError**)error;
+ (NCLClientCertificate*)certificateForHost:(NSString*)host;
+ (BOOL)clearCertificateForHost:(NSString*)host;

+ (NSArray*)keychainItems;

@end
