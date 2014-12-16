//
//  LoginViewController.m
//  OAuthSample
//
//  Created by Amos Elmaliah on 9/26/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "NJOPLoginViewController.h"
#import "NJOPClient+Login.h"

@interface NJOPLoginViewController () <UITextFieldDelegate>
@property (nonatomic, strong) NJOPLoginViewUserInput* userInput;
@property (nonatomic, strong) id<Task>loginTask;
@end

@implementation NJOPLoginViewController

#pragma mark - UIViewController

#define USE_BLUR 0

- (void)viewDidLoad {
	[super viewDidLoad];
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

}

-(BOOL)shouldAutorotate {
	return NO;
}

#pragma mark - state changes

-(void)updateUIAfterTextEntry {

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

- (IBAction)signInAction:(id)sender {

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
				[UIView animateWithDuration:0.2 animations:^{
					[coverView setAlpha:0.0];
				} completion:^(BOOL finished) {
					[coverView removeFromSuperview];
				}];
				NSAssert(self.completionHandler, @"");
				self.completionHandler(self);
			}
			return nil;
		}];
	}
}

@end