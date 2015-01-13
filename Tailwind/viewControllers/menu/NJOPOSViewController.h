//
//  NJOPOSViewController.h
//  Tailwind
//
//  Created by netjets on 1/12/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPActionButton.h"

@protocol NJOPOSViewControllerDelegate <NSObject>
- (void) resetButtonState;
@end

@interface NJOPOSViewController : UIViewController

@property (weak, nonatomic) IBOutlet NJOPActionButton *latenessNotificationButton;
@property (weak, nonatomic) IBOutlet UISlider *latenessSlider;

@property (nonatomic, assign) id delegate;
- (IBAction)sliderChanged:(id)sender;

@end
