//
//  NJVerticalTabViewController.m
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "NJVerticalTabViewController.h"

@interface NJVerticalTabViewController ()

@end

@implementation NJVerticalTabViewController

-(void)registerReusableViews {

}

-(void)loadDataSource {
	NSArray* sections = @[@{
													kSimpleDataSourceSectionCellsKey : @[

															@{
																kSimpleDataSourceCellIdentifierKey	: @"NJVerticalTabCell",
																kSimpleDataSourceCellKeypaths				: @{
																		@"label.text" : @"brief",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: @"NJVerticalTabCell",
																kSimpleDataSourceCellKeypaths				: @{
																		@"label.text" : @"flights",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: @"NJVerticalTabCell",
																kSimpleDataSourceCellKeypaths				: @{
																		@"label.text" : @"book",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: @"NJVerticalTabCell",
																kSimpleDataSourceCellKeypaths				: @{
																		@"label.text" : @"account",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: @"NJVerticalTabCell",
																kSimpleDataSourceCellKeypaths				: @{
																		@"label.text" : @"contact owner service",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: @"NJVerticalTabCell",
																kSimpleDataSourceCellKeypaths				: @{
																		@"label.text" : @"settings",
																		}
																},
															]
													}];

	self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
	__weak NJVerticalTabViewController* wself = self;
	[self.dataSource setDidSelectBlock:^(UIViewController *viewContrller, NSIndexPath *indexPath) {
		if (wself && wself.delegate) {
			UIViewController* viewConotroller = [wself viewControllerForItemAtIndexPath:indexPath];
			if ([wself.delegate tabController:wself shouldSelectViewController:viewConotroller]) {
				if ([wself.delegate respondsToSelector:@selector(tabController:animationControllerForTransitionFromViewController:toViewController:)]) {
				}
			}
		}
	}];
}

-(UIViewController*)viewControllerForItemAtIndexPath:(NSIndexPath*)indexPath {
	return nil;
}

@end
