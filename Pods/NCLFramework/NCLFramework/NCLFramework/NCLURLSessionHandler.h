//
//  NCLURLSessionHandler.h
//  NCLFramework
//
//  Created by Chad Long on 6/23/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCLURLSessionHandler : NSObject <NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSString *username;

@end
