//
//  NJVerticalTabViewController.h
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"
#import "SimpleDataSourceCollectionViewController.h"

@class NJVerticalTabViewController;
@protocol NJVerticalTabControllerDelegate <NSObject>
@optional
- (BOOL)tabController:(NJVerticalTabViewController *)tabController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabController:(NJVerticalTabViewController *)tabController didSelectViewController:(UIViewController *)viewController;

- (void)tabController:(NJVerticalTabViewController *)tabController willBeginCustomizingViewControllers:(NSArray *)viewControllers;
- (void)tabController:(NJVerticalTabViewController *)tabController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed;
- (void)tabController:(NJVerticalTabViewController *)tabController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed;

- (NSUInteger)tabControllerSupportedInterfaceOrientations:(NJVerticalTabViewController *)tabController;
- (UIInterfaceOrientation)tabControllerPreferredInterfaceOrientationForPresentation:(NJVerticalTabViewController *)tabController;

- (id <UIViewControllerInteractiveTransitioning>)tabController:(NJVerticalTabViewController *)tabController
											interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController;

- (id <UIViewControllerAnimatedTransitioning>)tabController:(NJVerticalTabViewController *)tabController
						animationControllerForTransitionFromViewController:(UIViewController *)fromVC
																							toViewController:(UIViewController *)toVC ;

@end

@interface NJVerticalTabViewController : SimpleDataSourceCollectionViewController
@property (nonatomic, weak)id<NJVerticalTabControllerDelegate>delegate;
@end
