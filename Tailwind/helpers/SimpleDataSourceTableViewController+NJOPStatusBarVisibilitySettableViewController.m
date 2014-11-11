//
//  SimpleDataSourceTableViewController+NJOPStatusBarVisibilitySettableViewController.m
//  Tailwind
//
//  Created by Amos Elmaliah on 11/11/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController+NJOPStatusBarVisibilitySettableViewController.h"
#import <objc/runtime.h>

@implementation SimpleDataSourceTableViewController (NJOPStatusBarVisibilitySettableViewController)

static char prefersStatusBarHiddenKey;

-(BOOL)prefersStatusBarHidden {
	NSNumber* number = objc_getAssociatedObject(self, &prefersStatusBarHiddenKey);
	return number ? [number boolValue] : NO;
}

-(void)setPrefersStatusBarHidden:(BOOL)hidden {
	objc_setAssociatedObject(self, &prefersStatusBarHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self setNeedsStatusBarAppearanceUpdate];
}

@end

@implementation SimpleDataSourceCollectionViewController (NJOPStatusBarVisibilitySettableViewController)

static char prefersStatusBarHiddenKey;

-(BOOL)prefersStatusBarHidden {
	NSNumber* number = objc_getAssociatedObject(self, &prefersStatusBarHiddenKey);
	return number ? [number boolValue] : NO;
}

-(void)setPrefersStatusBarHidden:(BOOL)hidden {
	objc_setAssociatedObject(self, &prefersStatusBarHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self setNeedsStatusBarAppearanceUpdate];
}

@end
