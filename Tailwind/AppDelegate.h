//
//  AppDelegate.h
//  Tailwind
//
//  Created by Ryan Smith on 9/29/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPMenuViewController.h"
#import "NJOPContainerHolderViewController.h"
#import "NJOPReservation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NJOPContainerHolderViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NJOPMenuViewController *njopMenuViewController;
@property (nonatomic, assign) int currentStoryboardTypeInt;
@property (nonatomic, retain) NJOPContainerHolderViewController *containerVC;
@property (nonatomic, retain) NJOPReservation *selectedReservation; // we're keeping a selected reservation to pass amongst screens
@property (nonatomic, retain) NSString *subStoryboardName;
@property (nonatomic, retain) NSString *subViewControllerName;
@property (nonatomic, retain) NSNumber *shouldClearHistory;

- (void) goChangeScreen:(NSNotification *) aNotification;
- (void) hideKeyboard:(NSNotification *) aNotification; // dismissing keyboard focus

@end

