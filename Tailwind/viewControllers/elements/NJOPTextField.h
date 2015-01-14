//
//  NJOPTextField.h
//  Tailwind
//
//  Created by Angus.Lo on 1/13/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    dropDown,
    search
} iconType;

@interface NJOPTextField : UITextField
@property (nonatomic) BOOL hasDropDown;
@property (nonatomic) BOOL hasSearchIcon;

- (UIView*) getIconView:(iconType) icon;

@end
