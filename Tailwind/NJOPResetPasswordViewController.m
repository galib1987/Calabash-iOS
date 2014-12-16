//
//  NJOPResetPasswordViewController.m
//  Tailwind
//
//  Created by Amos Elmaliah on 12/16/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPResetPasswordViewController.h"

@interface NJOPResetPasswordViewController ()

@end

@implementation NJOPResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)submitAction:(id)sender {

	[self.submitButton removeTarget:self action:_cmd forControlEvents:UIControlEventTouchUpInside];
	[UIView animateWithDuration:0.3
									 animations:^{
										 [self.detailLabel setEnabled:NO];
										 [self.emailTextField setEnabled:NO];
										 [self.submitButton setEnabled:NO];
									 }];

	__weak typeof(self) wself = self;
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

		if(wself) {
			BOOL success = YES;
			if(success ) {
				typeof(wself) self = wself;

				[self.detailLabel setEnabled:YES];
				[self.emailTextField setEnabled:YES];
				[self.submitButton setEnabled:YES];
				[self.emailTextField removeFromSuperview];
				[UIView animateWithDuration:0.5
															delay:0.0
														options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
												 animations:^{
													 [self.detailLabel setAlpha:1.0];
													 [self.detailLabel setText:@"an email has been sent to:\n<email>\nPlease follow link in that email to complete your password reset"];
													 [self.submitButton setTitle:@"BACK TO LOGIN" forState:UIControlStateNormal];
													 [self.view setNeedsLayout];

												 } completion:^(BOOL finished) {
													 [self.submitButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
												 }];
			} else {
				[self.submitButton setEnabled:YES];
				[self.submitButton addTarget:self action:_cmd forControlEvents:UIControlEventTouchUpInside];
			}
		}
	});
}

-(void)dismiss {

	if(self.presentingViewController) {
		[self.presentingViewController dismissViewControllerAnimated:YES completion:^{

		}];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

@end
