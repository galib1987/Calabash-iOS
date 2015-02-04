//
//  NJOPUser.h
//  Tailwind
//
//  Created by Chad Long on 1/26/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJOPUser : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) NSNumber *individualID;
@property (nonatomic, strong) NSNumber *defaultAccountID;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

+ (NJOPUser*)sharedInstance;

- (void)signOut;
- (void)saveToDisk;

@end
