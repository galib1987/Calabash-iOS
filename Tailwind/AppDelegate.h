//
//  AppDelegate.h
//  Tailwind
//
//  Created by Ryan Smith on 9/29/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NJOPMenuViewController *njopMenuViewController;

- (void) goChangeScreen:(NSNotification *) aNotification;
- (void) hideKeyboard:(NSNotification *) aNotification; // dismissing keyboard focus

@end

