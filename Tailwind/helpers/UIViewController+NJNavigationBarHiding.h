//
//  UIViewController+NJNavigationBarHiding.h
//  NetJets
//
//  Created by Amos Elmaliah on 10/9/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface UIViewController (NJNavigationBarHiding)
@property (nonatomic, assign) BOOL hidesNavigationOnScroll;
@end


@protocol NavigationBarHidingAdapterScrollViewContorller <NSObject>
-(UIScrollView*)njop_scrollView;
@end
@interface UITableViewController (NavigationBarHidingAdapterScrollViewContorller) <NavigationBarHidingAdapterScrollViewContorller>
@end

@interface UICollectionViewController (NavigationBarHidingAdapterScrollViewContorller) <NavigationBarHidingAdapterScrollViewContorller>
@end
