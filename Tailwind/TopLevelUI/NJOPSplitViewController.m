//
//  NJOPSplitViewController.m
//  Tailwind
//
//  Created by NetJets on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPSplitViewController.h"

@interface NJOPSplitViewController ()

@end

@implementation NJOPSplitViewController
-(void)viewDidLoad {
	[super viewDidLoad];
	self.delegate = self;
}

// This method allows a client to update any bar button items etc.
- (void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode {

}

// Called by the gesture AND barButtonItem to determine what they will set the display mode to (and what the displayModeButtonItem's appearance will be.) Return UISplitViewControllerDisplayModeAutomatic to get the default behavior.
- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc {
	return UISplitViewControllerDisplayModeAutomatic;
}

// Override this method to customize the behavior of `showViewController:` on a split view controller. Return YES to indicate that you've handled
// the action yourself; return NO to cause the default behavior to be executed.
- (BOOL)splitViewController:(UISplitViewController *)splitViewController showViewController:(UIViewController *)vc sender:(id)sender {
	return YES;
}

// Override this method to customize the behavior of `showDetailViewController:` on a split view controller. Return YES to indicate that you've
// handled the action yourself; return NO to cause the default behavior to be executed.
- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender {
	return YES;
}

// Return the view controller which is to become the primary view controller after `splitViewController` is collapsed due to a transition to
// the horizontally-compact size class. If you return `nil`, then the argument will perform its default behavior (i.e. to use its current primary view
// controller).
- (UIViewController *)primaryViewControllerForCollapsingSplitViewController:(UISplitViewController *)splitViewController {
	return nil;
}

// Return the view controller which is to become the primary view controller after the `splitViewController` is expanded due to a transition
// to the horizontally-regular size class. If you return `nil`, then the argument will perform its default behavior (i.e. to use its current
// primary view controller.)
- (UIViewController *)primaryViewControllerForExpandingSplitViewController:(UISplitViewController *)splitViewController {
	return nil;
}

// This method is called when a split view controller is collapsing its children for a transition to a compact-width size class. Override this
// method to perform custom adjustments to the view controller hierarchy of the target controller.  When you return from this method, you're
// expected to have modified the `primaryViewController` so as to be suitable for display in a compact-width split view controller, potentially
// using `secondaryViewController` to do so.  Return YES to prevent UIKit from applying its default behavior; return NO to request that UIKit
// perform its default collapsing behavior.
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
	return YES;
}

// This method is called when a split view controller is separating its child into two children for a transition from a compact-width size
// class to a regular-width size class. Override this method to perform custom separation behavior.  The controller returned from this method
// will be set as the secondary view controller of the split view controller.  When you return from this method, `primaryViewController` should
// have been configured for display in a regular-width split view controller. If you return `nil`, then `UISplitViewController` will perform
// its default behavior.
- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController {
	return nil;
}

- (NSUInteger)splitViewControllerSupportedInterfaceOrientations:(UISplitViewController *)splitViewController {
	return UIInterfaceOrientationLandscapeRight;
}

- (UIInterfaceOrientation)splitViewControllerPreferredInterfaceOrientationForPresentation:(UISplitViewController *)splitViewController {
	return UIInterfaceOrientationLandscapeRight;
}

@end
