//
//  NJOPConfig.h
//  Tailwind
//
//  Created by netjets on 1/14/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defines.h"

// Some core configuration methods
@interface NJOPConfig : NSObject

@property (nonatomic, assign) BOOL loadStaticJSON;

+ (NJOPConfig *)sharedInstance;
- (BOOL) shouldSeeWelcomeScreen; // whether we display the welcome screen or not
- (void) hasSeenWelcomeScreen; // set so we don't see welcome screen again
- (void) hideKeyboard; // the call to hide the keyboard
@end
