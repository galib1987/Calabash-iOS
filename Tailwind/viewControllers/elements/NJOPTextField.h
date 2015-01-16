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

@protocol NJOPTextFieldElement
@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(nonatomic, copy) NSString *text;
@end

@interface NJOPTextField : UITextField <NJOPTextFieldElement>
@property (nonatomic) BOOL hasDropDown;
@property (nonatomic) BOOL hasSearchIcon;

- (UIView*) getIconView:(iconType) icon;

@end
