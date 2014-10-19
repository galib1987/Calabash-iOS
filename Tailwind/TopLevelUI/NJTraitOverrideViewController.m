//
//  TraitOverrideViewController.m
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "NJTraitOverrideViewController.h"
#import "NJOPBriefViewController.h"
#import "NJVerticalTabViewController.h"
#import "NJOPSplitViewController.h"

@interface NJTraitOverrideViewController () <JNOPVerticalTabViewControllerDelegate>
@property (nonatomic,weak) UIViewController* currentViewContorller;
@property (nonatomic,strong) IBOutlet NJOPBriefViewController* briefViewController;
@property (nonatomic,strong) IBOutlet NJOPSplitViewController* splitViewController;

@end

@implementation NJTraitOverrideViewController


-(NJOPBriefViewController *)briefViewController {
	if (!_briefViewController) {
		_briefViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([NJOPBriefViewController class])];
	}
	return _briefViewController;

}
- (void)viewWillTransitionToSize:(CGSize)size
			 withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator  {
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	for (UIViewController*viewContorller in [self childViewControllers]) {
		if ([viewContorller isKindOfClass:[NJVerticalTabViewController class]]) {
			[(NJVerticalTabViewController*)viewContorller setDelegate:self];
		}

		if ([viewContorller isKindOfClass:[NJOPSplitViewController class]]) {
			self.splitViewController = (NJOPSplitViewController*)viewContorller;
			self.currentViewContorller = viewContorller;
		} else if([viewContorller isKindOfClass:[NJOPBriefViewController class]]) {
			self.briefViewController = (NJOPBriefViewController*)viewContorller;
			self.currentViewContorller = viewContorller;
		}
	}
}

-(UIViewController*)viewControllerAtIndex:(NSUInteger)index {
	switch (index) {
  case 0:
			return self.briefViewController;
			break;
	case 1:
			return self.splitViewController;
  default:
			break;
	}
	return nil;
}


- (void)tabBarViewController:(NJVerticalTabViewController *)tabBar
				didSelectItemAtIndex:(NSUInteger)index {

	return;
	/*TODO: write vertical tabbar implementation */
	UIViewController* toViewController = [self viewControllerAtIndex:index];
	if (toViewController && toViewController != self.currentViewContorller) {
		if (!toViewController.parentViewController) {
			[self addChildViewController:toViewController];
		}
		__weak UIViewController* fromViewController = self.currentViewContorller;

		fromViewController.view.alpha = 1.0;
		toViewController.view.alpha = 0.0;

		[self transitionFromViewController:fromViewController
											toViewController:toViewController
															duration:.23
															 options:0
														animations:^{
															fromViewController.view.alpha = 0.0;
															toViewController.view.alpha = 1.0;
														}
														completion:^(BOOL finished) {
															[fromViewController removeFromParentViewController];
															self.currentViewContorller = toViewController;
														}];
	}
}

@end
