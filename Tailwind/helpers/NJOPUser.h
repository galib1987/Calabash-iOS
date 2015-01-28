//
//  NJOPUser.h
//  Tailwind
//
//  Created by Chad Long on 1/26/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJOPUser : NSObject

@property (atomic, copy) NSString *username;
@property (atomic, copy) NSNumber *individualID;
@property (atomic, copy) NSNumber *defaultAccountID;
@property (atomic, copy) NSString *firstName;
@property (atomic, copy) NSString *lastName;

+ (NJOPUser*)sharedInstance;

- (void)signOut;
- (void)saveToDisk;

@end
