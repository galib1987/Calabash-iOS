//
//  NJOPResigner.h
//  Tailwind
//
//  Created by netjets on 1/23/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJOPResigner : NSObject

+ (void)dismissKeyboardControl;
+ (void)globalResignFirstResponder;
+ (void)globalResignFirstResponderRec:(UIView*) view;


@end
