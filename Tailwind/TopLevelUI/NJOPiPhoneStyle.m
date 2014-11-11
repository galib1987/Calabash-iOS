//
//  NJOPiPhoneStyle.m
//  Tailwind
//
//  Created by Amos Elmaliah on 11/11/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPiPhoneStyle.h"
#import "UIViewController+NJNavigationBarHiding.h"
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
		viewController.toolbarItems = self.toolbarItems;
		//		[viewController setHidesNavigationOnScroll:YES];
		//		[viewController setHidesToolbarOnScroll:YES];
	} else if([viewController isKindOfClass:[ReservationDetailViewController class]]) {

		viewController.navigationController.toolbarHidden = NO;
		viewController.toolbarItems = self.toolbarItems;
//		[viewController setHidesNavigationOnScroll:YES];
//		[viewController setHidesToolbarOnScroll:YES];
//		[viewController setHidesStatusBarOnScroll:YES];
	}
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

}

@end
