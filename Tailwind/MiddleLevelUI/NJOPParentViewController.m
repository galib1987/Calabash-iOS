//
//  NJOPParentViewController.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/20/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPParentViewController.h"
#import "NJOPNavigationTitleView.h"

@interface NJOPParentViewController ()
@end

@implementation NJOPParentViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = SCROLLVIEW_BACKGORUND_COLOR;
	UINib* nib = [UINib nibWithNibName:@"NJOPNavigationTitleView"
															bundle:nil];

	NJOPNavigationTitleView* titleView = (NJOPNavigationTitleView*)[nib instantiateWithOwner:nil
																																									 options:nil][0];
	titleView.fittedSizeForSize = ^(CGSize size, CGSize fittedSize) {
		fittedSize.width = size.width;
		return fittedSize;
	};

	
	[titleView setAutoresizingMask:UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight];

	NSAssert([titleView isKindOfClass:[NJOPNavigationTitleView class]], @"expected a view");
	[self.navigationItem setTitleView:titleView];
}

@end
