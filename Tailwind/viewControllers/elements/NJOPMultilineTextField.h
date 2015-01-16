//
//  NJOPMultilineTextField.h
//  Tailwind
//
//  Created by Angus.Lo on 1/16/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "SZTextView.h"
#import "NJOPTextField.h"

@interface NJOPMultilineTextField : SZTextView <NJOPTextFieldElement>

@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(nonatomic, copy) NSString *text;

@end
