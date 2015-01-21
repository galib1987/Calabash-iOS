//
//  NCLSessionManager.h
//  NCLFramework
//
//  Created by Chad Long on 6/26/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCLURLSession.h"
#import "NCLOAuthClient.h"

@interface NCLSessionManager : NSObject

+ (NCLSessionManager*)sharedInstance;

- (void)reset;
- (NCLURLSession*)sessionForUsername:(NSString*)username host:(NSString*)host isOAuthClient:(BOOL)isOAuthClient;

@end
