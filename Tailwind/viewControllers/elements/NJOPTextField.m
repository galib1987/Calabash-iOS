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

- (void)setText:(NSString *)text {
    [super setText:text];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (self.enabled) {
        self.alpha = 1;
    } else {
        self.alpha = 0.75;
    }
    // Code to change placeholder color for disabled fields
    /*if (self.enabled) {
        [[UILabel appearanceWhenContainedIn:[UITextField class], nil] setTextColor:[UIColor blackColor]];
    } else {
        [[UILabel appearanceWhenContainedIn:[UITextField class], nil] setTextColor:[UIColor lightGrayColor]];
    }
    // trigger redraw
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
    NSDictionary* attributes = @{NSForegroundColorAttributeName:[UIColor redColor]}; // some different color
    [attributedString setAttributes:attributes range:NSMakeRange(0, [attributedString length])];
    [self setAttributedPlaceholder:attributedString];*/
}

- (void)setHasDropDown:(BOOL)hasDropDown {
    _hasDropDown = hasDropDown;
    
    if (self.hasDropDown) {
        UIView *dropDownView = [self getIconView:dropDown];
        self.rightView = dropDownView;
        self.rightViewMode = UITextFieldViewModeAlways;
    } else {
        self.rightView = nil;
    }
}

- (void)setHasSearchIcon:(BOOL)hasSearchIcon {
    _hasSearchIcon = hasSearchIcon;
    
    if (self.hasSearchIcon) {
        UIView *searchIconView = [self getIconView:search];
        self.rightView = searchIconView;
        self.rightViewMode = UITextFieldViewModeAlways;
    } else {
        self.rightView = nil;
    }
}

- (UIView*)getIconView:(iconType)icon {
    UIImageView *iconImageView;
    CGFloat width;
    switch (icon) {
        case dropDown:
            iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdownarrow"]];
            width = 19;
            break;
        case search:
            iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchicon"]];
            width = 22;
            break;
        default:
            break;
    }
    iconImageView.frame = CGRectMake(0, 0, width, width);
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width*2, width)]; // width*2 for right padding
    [iconView addSubview:iconImageView];
    iconView.userInteractionEnabled = false;
    return iconView;
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: self.font};
    CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
    [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];
}

@end
