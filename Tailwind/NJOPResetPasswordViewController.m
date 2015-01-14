//
//  NJOPResetPasswordViewController.m
//  Tailwind
//
//  Created by NetJets on 12/16/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPResetPasswordViewController.h"

@interface NJOPResetPasswordViewController ()

@end

@implementation NJOPResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)submitAction:(id)sender {

	[self.submitButton removeTarget:self action:_cmd forControlEvents:UIControlEventTouchUpInside];
	[UIView animateWithDuration:0.3
									 animations:^{
										 [self.detailLabel setAlpha:0.7];
										 [self.emailTextField setEnabled:NO];
										 [self.submitButton setEnabled:NO];
									 }];

	__weak typeof(self) wself = self;
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

		if(wself) {
			BOOL success = YES;
			if(success ) {
				typeof(wself) self = wself;

				[self.detailLabel setText:@"an email has been sent to:\n<email>\nPlease follow link in that email to complete your password reset"];
				[self.detailLabel setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
				[self.detailLabel setAlpha:1.0];
				[self.emailTextField setEnabled:YES];
				[self.submitButton setEnabled:YES];
				[self.emailTextField removeFromSuperview];
				[self.submitButton setTitle:@"BACK TO LOGIN" forState:UIControlStateNormal];
				[UIView animateWithDuration:0.18
															delay:0.0
														options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
												 animations:^{
													 [self.detailLabel setTransform:CGAffineTransformMakeScale(1.005, 1.005)];
													 [self.view setNeedsLayout];

												 } completion:^(BOOL finished) {
													 [self.submitButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
													 [UIView animateWithDuration:1.0
																								 delay:0.0
																							 options:UIViewAnimationOptionBeginFromCurrentState  | UIViewAnimationOptionCurveEaseOut
																						animations:^{
																							[self.detailLabel setTransform:CGAffineTransformIdentity];
																						} completion:^(BOOL finished) {

																						}];
												 }];
			} else {
				[self.emailTextField setEnabled:YES];
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
