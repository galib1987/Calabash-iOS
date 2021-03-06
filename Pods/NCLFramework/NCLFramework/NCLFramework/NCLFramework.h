//
//  NCLFramework.h
//  NCLFramework
//
//  Created by Chad Long on 7/10/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import "NCLErrorPresenter.h"
#import "NCLInfoPresenter.h"
#import "NCLMessage.h"
#import "NCLHTTPClient.h"
#import "NCLURLRequest.h"
#import "Reachability.h"
#import "NCLNetworking.h"
#import "NCLPersistenceManager.h"
#import "NCLPersistenceUtil.h"
#import "NCLUserPassword.h"
#import "NCLClientCertificate.h"
#import "NCLKeychainStorage.h"
#import "NSObject+Utility.h"
#import "NSDate+Utility.h"
#import "NSDateFormatter+Utility.h"
#import "NSData+Utility.h"
#import "NSError+Utility.h"
#import "NSNumber+Utility.h"
#import "NSDecimalNumber+Utility.h"
#import "NSString+Utility.h"
#import "UIDevice+Utility.h"
#import "UIView+Utility.h"
#import "UIColor+Utility.h"
#import "UIViewController+Utility.h"
#import "UIApplication+Utility.h"
#import "UIImage+Utility.h"
#import "NSManagedObjectContext+Utility.h"
#import "NCLAnalytics.h"
#import "NCLAnalyticsEvent.h"
#import "NCLAnalyticsTableViewController.h"
#import "NCLManagedOperation.h"
#import "NCLOperationManager.h"
#import "NCLSimulatedHTTPResponse.h"
#import "NCLSessionManager.h"
#import "NCLURLSession.h"
#import "NCLURLSessionHandler.h"
#import "NCLErrorDelegate.h"
#import "NCLOAuthClient.h"
#import "NCLOAuthCredential.h"

extern NSString * const NCLDateFormatShouldUseTwoDigitDateComponentsKey;
extern NSString * const NCLDateFormatShouldUseMilitaryTimeKey;
extern NSString * const NCLDateFormatShouldStripCommasKey;
extern NSString * const NCLDateFormatShouldStripColonsKey;

typedef enum
{
    LogLevelNONE = 1,
    LogLevelINFO,
    LogLevelDEBUG,
    LogLevelTRACE,
} LogLevel;

@interface NCLFramework : NSObject

+ (void)setLogLevel:(LogLevel)logLevel;
+ (LogLevel)logLevel;

+ (void)setAppPreference:(NSString*)key value:(NSObject*)value;
+ (NSObject*)appPreferenceForKey:(NSString*)key;

+ (void)setErrorDelegate:(id<NCLErrorDelegate>)delegate;
+ (id<NCLErrorDelegate>)errorDelegate;

+ (void)presentError:(NSError*)error;

@end