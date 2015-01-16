//
//  NJOPMultilineTextField.m
//  Tailwind
//
//  Created by Angus.Lo on 1/16/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPMultilineTextField.h"

@implementation NJOPMultilineTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    
    if (self.enabled) {
        self.alpha = 1;
        self.userInteractionEnabled = true;
    } else {
        self.alpha = 0.75;
        self.userInteractionEnabled = false;
    }
}

@end
