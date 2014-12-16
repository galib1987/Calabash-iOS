//
//  NJOPBlockStyleButton.m
//  Tailwind
//
//  Created by DAVID LIN on 10/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPBlockStyleButton.h"

@implementation NJOPBlockStyleButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;
    }
    return self;
}

@end
