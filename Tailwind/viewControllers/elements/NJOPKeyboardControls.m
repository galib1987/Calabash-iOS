//
//  NJOPKeyboardControls.m
//  Tailwind
//
//  Created by Angus.Lo on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPKeyboardControls.h"

@implementation NJOPKeyboardControls

- (void)updateButtonsAt:(NSInteger)index {
    if (self.hasPreviousNext) {
        self.previousButton.enabled = (index > 0 && [self.inputFields objectAtIndex:index-1] != NSRangeException);
        self.nextButton.enabled = [self.inputFields objectAtIndex:index+1] != NSRangeException;
    }
}

@end
