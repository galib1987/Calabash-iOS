//
//  UIViewController+Utility.m
//  NCLFramework
//
//  Created by Jeff Bailey on 6/16/14.
//  Copyright (c) 2014 NetJets, Inc. All rights reserved.
//

#import "UIViewController+Utility.h"

@implementation UIViewController (Utility)

- (void)sendResignFirstResponderMessage
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:self forEvent:nil];
}

@end
