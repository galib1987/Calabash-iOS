//
//  NJOPResetPasswordViewController.h
//  Tailwind
//
//  Created by NetJets on 12/16/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPConfig.h"

@interface NJOPResetPasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *netJetsLogoImageView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray* topViews;

- (IBAction)submitAction:(id)sender;

- (void) tapGesture:(UIGestureRecognizer *) tap;

- (void) styleNavigationBar;

@end
