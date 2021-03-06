//
//  NJOPSettingsBaseViewController.h
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJOPSettingsBaseViewController : UIViewController

@property (nonatomic, assign) BOOL hideCustomBackButton;

- (void)displayDarkOverlay:(BOOL)show;

@end
