//
//  NCLErrorDelegate.h
//  NCLFramework
//
//  Created by Chad Long on 7/1/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NCLErrorDelegate <NSObject>

+ (void)handleError:(NSError*)error;

@end
