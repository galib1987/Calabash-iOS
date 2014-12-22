//
//  LoginViewController.h
//  OAuthSample
//
//  Created by NetJets on 9/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
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
- (void) displayHome; // displays the home storyboard
- (void) presentMessage:(NSString *) message withTitle:(NSString *) title; // temporary for testing

@end
