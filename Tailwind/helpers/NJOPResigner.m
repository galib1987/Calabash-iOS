//
//  NJOPResigner.m
//  Tailwind
//
//  Created by netjets on 1/23/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPResigner.h"

@implementation NJOPResigner

+ (void)dismissKeyboardControl {
    [self globalResignFirstResponder];
}

+ (void) globalResignFirstResponder {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    for (UIView * view in [window subviews]){
        [self globalResignFirstResponderRec:view];
    }
}

+ (void) globalResignFirstResponderRec:(UIView*) view {
    if ([view respondsToSelector:@selector(resignFirstResponder)]){
        [view resignFirstResponder];
    }
    for (UIView * subview in [view subviews]){
        [self globalResignFirstResponderRec:subview];
    }
}

@end
