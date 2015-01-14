//
//  NJOPSession.m
//  Tailwind
//
//  Created by netjets on 12/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPSession.h"

@implementation NJOPSession

+ (NJOPSession *) sharedInstance {
    static NJOPSession * sharedInstance;
    @synchronized(self)	{
        if (!sharedInstance) {
            sharedInstance = [[NJOPSession alloc] init];
        }
        return sharedInstance;
    }
}

- (id) init {
    self = [super init];
    if (self) {
        self.individual = nil;
        self.reservations = [NSArray array];
        self.brief = nil;
    }
    return self;
}

@end
