//
//  NJOPTextField.m
//  Tailwind
//
//  Created by Angus.Lo on 1/13/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPTextField.h"

@implementation NJOPTextField
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)]; // left padding
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

- (void)setHasDropDown:(BOOL)hasDropDown {
    _hasDropDown = hasDropDown;
    
    if (self.hasDropDown) {
        UIImageView *dropDownImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdownarrow"]];
        dropDownImageView.frame = CGRectMake(0, 0, 19, 19);
        dropDownImageView.contentMode = UIViewContentModeScaleAspectFit;
        UIView *dropDownView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 19*2, 19)];
        [dropDownView addSubview:dropDownImageView];
        dropDownView.userInteractionEnabled = false;
        
        self.rightView = dropDownView;
        self.rightViewMode = UITextFieldViewModeAlways;
    } else {
        self.rightView = nil;
    }
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
    [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];
}

@end
