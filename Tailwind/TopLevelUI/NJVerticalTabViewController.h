//
//  NJVerticalTabViewController.h
//  TailWind
//
//  Created by NetJets on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"
#import "SimpleDataSourceCollectionViewController.h"
#import "NJVerticalTabCell.h"

@class NJVerticalTabViewController;
@protocol JNOPVerticalTabViewControllerDelegate<NSObject>
@optional

- (void)tabBarViewController:(NJVerticalTabViewController *)tabBar
							 didSelectItemAtIndex:(NSUInteger)index; // called when a new view is selected by the user (but not programatically)
- (void) goToSection:(NSString *)section; // load in a new section
@end


@interface NJVerticalTabViewController : SimpleDataSourceCollectionViewController
@property (nonatomic, weak)IBOutlet id<JNOPVerticalTabViewControllerDelegate>delegate;
@end
