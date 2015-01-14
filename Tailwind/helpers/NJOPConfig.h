//
//  NJOPConfig.h
//  Tailwind
//
//  Created by netjets on 1/14/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>

// Some core configuration methods
@interface NJOPConfig : NSObject

+ (NJOPConfig *)sharedInstance;
- (BOOL) shouldSeeWelcomeScreen; // whether we display the welcome screen or not
- (void) hasSeenWelcomeScreen; // set so we don't see welcome screen again
@end
