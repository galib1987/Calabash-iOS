//
//  NJOPOSViewController.h
//  Tailwind
//
//  Created by netjets on 1/12/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NJOPOSViewControllerDelegate <NSObject>
- (void) resetButtonState;
@end

@interface NJOPOSViewController : UIViewController

@property (nonatomic, assign) id delegate;

@end
