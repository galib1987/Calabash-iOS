//
//  NJVerticalTabViewController.m
//  TailWind
//
//  Created by NetJets on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJVerticalTabViewController.h"

@interface NJVerticalTabViewController ()

@end

@implementation NJVerticalTabViewController

-(void)viewDidLoad {
	[super viewDidLoad];
	[self.collectionView setBackgroundColor:VERTICAL_TABBAR_BACKGORUND_COLOR];
}

-(void)registerReusableViews {

}

-(void)loadDataSource {
	NSArray* sections = @[@{
													kSimpleDataSourceSectionCellsKey : @[

															@{
																kSimpleDataSourceCellIdentifierKey	: @"NJVerticalTabCell",
																kSimpleDataSourceCellKeypaths				: @{
																		@"label.text" : @"home",
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
																		@"label.text" : @"owner service",
																		}
																},
                                                            /*
															@{
																kSimpleDataSourceCellIdentifierKey	: @"NJVerticalTabCell",
																kSimpleDataSourceCellKeypaths				: @{
																		@"label.text" : @"settings",
																		}
																},
                                                             */
															]
													}];

	self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
	__weak NJVerticalTabViewController* wself = self;
	[self.dataSource setDidSelectBlock:^(UIViewController *viewContrller, NSIndexPath *indexPath) {
		if (wself && wself.delegate) {
			[wself.delegate tabBarViewController:wself
										 didSelectItemAtIndex:indexPath.item];
		}
	}];
}

-(UIViewController*)viewControllerForItemAtIndexPath:(NSIndexPath*)indexPath {
	return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NJVerticalTabCell *cell = (NJVerticalTabCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSLog(@"touched cell %@ at indexPath %@", cell.label.text, indexPath);
    NSString *section = cell.label.text;
    [self goToSection:section];
}

- (void) goToSection:(NSString *)section {
    if ([section isEqualToString:@"home"]) {
        
    }
    if ([section isEqualToString:@"flights"]) {
        
    }
    if ([section isEqualToString:@"book"]) {
        
    }
    if ([section isEqualToString:@"account"]) {
        
    }
    if ([section isEqualToString:@"owner services"]) {
        
    }
    if ([section isEqualToString:@""]) {
        
    }
}

@end
