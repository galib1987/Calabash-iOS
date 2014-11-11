//
//  NJOPiPhoneStyle.m
//  Tailwind
//
//  Created by Amos Elmaliah on 11/11/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPiPhoneStyle.h"
#import "UIViewController+NJNavigationBarHiding.h"
#import "NJOPSummaryNavigationTitleView.h"
#import "NJOPNavigationBar.h"
#import "NJOPPPhoneHomeViewController.h"
#import "ReservationDetailViewController.h"

@interface NJOPiPhoneStyle ()
@property (nonatomic, strong) NSArray* toolbarItems;
@end

@implementation NJOPiPhoneStyle

-(NSArray *)toolbarItems {

	if (!_toolbarItems) {
		UIButton* button = nil;
		{
			UIImage *background = [UIImage imageNamed:@"icon_nav_menu"];
			//	UIImage *backgroundSelected = [UIImage imageNamed:@"icon_selected.png"];
			button = [UIButton buttonWithType:UIButtonTypeCustom];
			//	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside]; //adding action
			[button setBackgroundImage:background forState:UIControlStateNormal];
			//	[button setBackgroundImage:backgroundSelected forState:UIControlStateSelected];
			button.frame = CGRectMake(0 ,0,35,35);
		}
		UIBarButtonItem *actionsBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];

		{
			UIImage *background = [UIImage imageNamed:@"icon_contact_os"];
			//	UIImage *backgroundSelected = [UIImage imageNamed:@"icon_selected.png"];
			button = [UIButton buttonWithType:UIButtonTypeCustom];
			//	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside]; //adding action
			[button setBackgroundImage:background forState:UIControlStateNormal];
			//	[button setBackgroundImage:backgroundSelected forState:UIControlStateSelected];
			button.frame = CGRectMake(0 ,0,35,35);
		}
		UIBarButtonItem *phoneBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];


		UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

		UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		fixedSpace.width = 10.0;

		_toolbarItems = [NSArray arrayWithObjects:
										 flexibleSpace,
										 actionsBarItem,
										 flexibleSpace,
										 phoneBarItem,
										 flexibleSpace,
										 nil];
	}
	return _toolbarItems;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

	if ([viewController isKindOfClass:[NJOPPPhoneHomeViewController class]]) {
		viewController.navigationController.toolbarHidden = NO;
		viewController.navigationController.navigationBarHidden = NO;

		[viewController setHidesNavigationOnScroll:YES];
		[viewController setHidesToolbarOnScroll:YES];
		[[viewController.navigationController toolbar] setBarTintColor:TOOLBAR_BACKGROUND_COLOR];
		[[viewController.navigationController toolbar] setTintColor:NAVIGATIONBAR_TINT_COLOR];

		viewController.toolbarItems = self.toolbarItems;
		UINib* nib = [UINib nibWithNibName:NSStringFromClass([NJOPSummaryNavigationTitleView class])
																bundle:nil];
		NJOPSummaryNavigationTitleView*titleView = [nib instantiateWithOwner:nil
																																 options:nil][0];

		viewController.navigationItem.titleView = titleView;
		[(NJOPNavigationBar*)viewController.navigationController.navigationBar setSizeThatFitsBlock:^CGSize(CGSize size, CGSize fittedSize) {
			CGFloat height = [titleView systemLayoutSizeFittingSize:fittedSize].height;
			return CGSizeMake(fittedSize.width, height + 20);
		}];
	} else if([viewController isKindOfClass:[ReservationDetailViewController class]]) {

		viewController.navigationController.toolbarHidden = NO;
		viewController.navigationController.navigationBarHidden = NO;

		[viewController setHidesNavigationOnScroll:YES];
		[viewController setHidesToolbarOnScroll:YES];
		[viewController setHidesStatusBarOnScroll:YES];
		[[viewController.navigationController toolbar] setBarTintColor:TOOLBAR_BACKGROUND_COLOR];
		[[viewController.navigationController toolbar] setTintColor:NAVIGATIONBAR_TINT_COLOR];

		viewController.toolbarItems = self.toolbarItems;
		UINib* nib = [UINib nibWithNibName:NSStringFromClass([NJOPSummaryNavigationTitleView class])
																bundle:nil];
		NJOPSummaryNavigationTitleView*titleView = [nib instantiateWithOwner:nil
																																 options:nil][0];

		viewController.navigationItem.titleView = titleView;
		[(NJOPNavigationBar*)viewController.navigationController.navigationBar setSizeThatFitsBlock:^CGSize(CGSize size, CGSize fittedSize) {
			CGFloat height = [titleView systemLayoutSizeFittingSize:fittedSize].height;
			return CGSizeMake(fittedSize.width, height + 20);
		}];
	}
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

}

@end
