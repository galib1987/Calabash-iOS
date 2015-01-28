//
//  LoginViewController.m
//  OAuthSample
//
//  Created by NetJets on 9/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPLoginViewController.h"
#import "NJOPClient+Login.h"
#import "NCLInfoPresenter.h"
#import "NJOPConfig.h"
#import "NJOPOAuthClient.h"
#import "NJOPFlightHTTPClient.h"

@interface NJOPLoginViewController () <UITextFieldDelegate>
@property (nonatomic, strong) NJOPLoginViewUserInput* userInput;
@property (nonatomic, strong) id<Task>loginTask;
@end

@implementation NJOPLoginViewController

#pragma mark - UIViewController

#define API_SOURCE_IDENTIFIER @"OwnersPortalIOSUser"
#define API_HOSTNAME @"servicesdev2.netjets.com"
#define URL_BRIEF @"/op/v1/brief"
#define URL_RESERVATIONS @"/op/v1/reservations"
#define URL_CONTRACTS @"/op/v1/contracts"

#define USE_BLUR 0

- (void)viewDidLoad {
	[super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:YES];
    [self styleNavigationBar];
	_userInput = [NJOPLoginViewUserInput new];
	[_loginButton setEnabled:[self.userInput validateWithError:nil]];
#if USE_BLUR
	UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
	_blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
	_blurView.frame = self.backgroundImageView.bounds;
	_blurView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	[_backgroundImageView addSubview:_blurView];
	[self.view insertSubview:_backgroundImageView atIndex:0];
#endif // USE_BLUR
	_userNameTextField.delegate = self;
	_passwordTextField.delegate = self;
    
    
    // tap gesture to dismiss keyboard
    // we put this on any UIView that we want to be able to dismiss keyboard from
    // also copy the tapGesture method from below
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];

}

-(BOOL)shouldAutorotate {
	return NO;
}

#pragma mark - state changes

-(void)updateUIAfterTextEntry {
    // we don't allow submission until username and password entries seem to be appropriate
	BOOL valid = [self.userInput validateWithError:nil];
	self.userNameTextField.returnKeyType = valid ? UIReturnKeyGo : UIReturnKeyNext;
	self.passwordTextField.returnKeyType = valid ? UIReturnKeyGo : UIReturnKeyNext;
	[self.loginButton setEnabled:valid];
	if (![self.loginButton actionsForTarget:self forControlEvent:UIControlEventTouchUpInside]) {
		[self.loginButton addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
	}
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	[self updateUIAfterTextEntry];
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

	NSString* text = !textField.text ? textField.text : [textField.text stringByAppendingString:string];
	if (textField == self.passwordTextField) {
		self.userInput.password = text;
	} else if(textField == self.userNameTextField) {
		self.userInput.username = text;
	}
	[self updateUIAfterTextEntry];
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if([self.userInput validateWithError:nil]) {
		[self signInAction:nil];
		//[self performSegueWithIdentifier:@"tryLogin" sender:textField];
	} else if (textField == self.userNameTextField) {
		[self.passwordTextField becomeFirstResponder];
	} else {
		[self.userNameTextField becomeFirstResponder];
	}
	return YES;
}

#pragma mark - Actions

-(void)presentError:(NSError*)error {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:error.localizedDescription message:error.localizedFailureReason preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
	}];
	[alertController addAction:dismissAction];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void) presentMessage:(NSString *) message withTitle:(NSString *) title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:dismissAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)signInAction:(id)sender {

    // bypass VPN
    if (USE_STATIC_DATA == 1) {
        [self displayHome];
    } else {
	if (!self.loginTask) {

		UIView* coverView = [UIView new];
		coverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.7];
		coverView.frame = self.view.bounds;
		UILabel* label = [UILabel new];
		label.textColor = [UIColor whiteColor];
		label.text = @"Loading";
		label.textAlignment = NSTextAlignmentCenter;
		label.frame = coverView.bounds;
		[coverView addSubview:label];
		[coverView setUserInteractionEnabled:NO];
		[self.view addSubview:coverView];
        [[NJOPConfig sharedInstance] hideKeyboard];
        
        coverView.alpha = 0.0;
        [UIView animateWithDuration:0.2 animations:^{
            [coverView setAlpha:1.0];
        } completion:^(BOOL finished) {
        
            // login should be synchronous. we can't really do anything if login fails for any reason
            NJOPOAuthClient *session = [NJOPOAuthClient sharedInstance];
            [session login:self.userNameTextField.text withPassword:self.passwordTextField.text];
            if (session.isLoggedIn == YES) {
                /*
                [UIView animateWithDuration:0.2 animations:^{
                    [coverView setAlpha:0.0];
                } completion:^(BOOL finished) {
                    [coverView removeFromSuperview];
                    [self displayHome];
                }];
                 */
                
                [self displayHome];
            } else {
                [self presentMessage:@"Error" withTitle:@"Login Failed. Please try again."];
                [UIView animateWithDuration:0.2 animations:^{
                    [coverView setAlpha:0.0];
                } completion:^(BOOL finished) {
                    [coverView removeFromSuperview];
                }];
            } // end isLoggedIn
            
        }]; // end loading animation
        
        
        /*
		__weak NJOPLoginViewController* wself = self;
		self.loginTask = [[NJOPClient loginWithUserInputs:self.userInput] continueWithBlock:^id(id result) {
			NJOPLoginViewController* self = wself;

			NSError* error = [(id<Task>)result error];
			if (error) {
				self.loginTask = nil;
				[self presentError:error];
				[UIView animateWithDuration:0.2 animations:^{
					[coverView setAlpha:0.0];
				} completion:^(BOOL finished) {
					[coverView removeFromSuperview];
				}];
			} else {
				label.text = @"Done";
                self.loginTask = nil;
				[UIView animateWithDuration:0.2 animations:^{
					[coverView setAlpha:0.0];
				} completion:^(BOOL finished) {
					[coverView removeFromSuperview];
                    [self displayHome];
				}];
				//NSAssert(self.completionHandler, @"");
				//self.completionHandler(self);
			}
			return nil;
		}];
        */
	} // end if loginTask
    } // end else static
}

- (void) displayHome {

    
    NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Home",menuStoryboardName,@"HomeViewController",menuViewControllerName, [NSNumber numberWithInt:isContainerScreen], appStoryboardIdentifier, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif]; // using NSNotifications for menu changes because we also need to do other things in other places

}

- (void) tapGesture:(UIGestureRecognizer *) tap {
    // we're going to dismiss keyboard
    [[NJOPConfig sharedInstance] hideKeyboard];
}

#pragma mark - styling navigation bar

- (void) styleNavigationBar {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTranslucent:YES];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    if (self.navigationController != nil)  {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTranslucent:YES];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    if (self.navigationItem != nil) {
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"netjets-logo"]];
    }

}

@end
