//
//  NJOPConfig.m
//  Tailwind
//
//  Created by netjets on 1/14/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPConfig.h"

@implementation NJOPConfig

+ (NJOPConfig *)sharedInstance {
    static NJOPConfig *sharedInstance;
    
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[NJOPConfig alloc]init];
        }
        return sharedInstance;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        // initialization code goes in here
        self.loadStaticJSON = NO;
    }
    return self;
}


- (BOOL) shouldSeeWelcomeScreen {
    NSDate *welcomeDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"welcomeScreenDate"];
    if (welcomeDate == nil) {
        return YES;
    } else {
        // what we want to do is to see if the welcome date is older than any updated welcome date (to show welcome screen again if there are new features)
        // that logic will go here
        return NO;
    }
    return YES; // if anything goes wrong, we show welcome screen
}

- (void) hasSeenWelcomeScreen {
    NSDate *theDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:theDate forKey:@"welcomeScreenDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) hideKeyboard {
    [[NSNotificationCenter defaultCenter] postNotificationName:dismissKeyboard object:self userInfo:nil];
}

@end
