//
//  NCLInfoPresenter.h
//  NCLFramework
//
//  Created by Chad Long on 8/29/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NCLMessage;

@interface NCLMessagePresenter : NSObject

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic) NSTimeInterval autoDismissDelay;

- (void)registerSoundNamed:(NSString*)name;

- (void)pushViewWithMessage:(NCLMessage*)message;
- (void)pushViewWithMessage:(NCLMessage*)message shouldAutoDismiss:(BOOL)shouldAutoDismiss;

- (void)popViewWithText:(NSString*)text;
- (void) removeAllPresenters: (UIView *) parentView;

@end
