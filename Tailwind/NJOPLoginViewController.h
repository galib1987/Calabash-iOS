//
//  LoginViewController.h
//  OAuthSample
//
//  Created by Amos Elmaliah on 9/26/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

@import Foundation;
@import UIKit;
@class NJOPLoginViewUserInput;

@interface NJOPLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *netJetsLogoImageView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray* topViews;
@property (nonatomic, strong) UIVisualEffectView *blurView;

@property (copy, nonatomic) void(^completionHandler)(NJOPLoginViewController*);

- (IBAction)signInAction:(id)sender;
@end