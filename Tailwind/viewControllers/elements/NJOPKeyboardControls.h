//
//  NJOPKeyboardControls.h
//  Tailwind
//
//  Created by Angus.Lo on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "APLKeyboardControls.h"

@interface NJOPKeyboardControls : APLKeyboardControls

@property (strong, nonatomic) UIBarButtonItem *customItem;

- (void)updateButtonsAt:(NSInteger)index;

@end
