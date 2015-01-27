//
//  NJOPFeedbackSentViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPFeedbackSentViewController.h"

@interface NJOPFeedbackSentViewController()

- (IBAction)goBackToSettingPressed:(id)sender;

@end

@implementation NJOPFeedbackSentViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.navigationItem.backBarButtonItem = nil;
}

- (IBAction)goBackToSettingPressed:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
