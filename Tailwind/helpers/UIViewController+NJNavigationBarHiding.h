//
//  UIViewController+NJNavigationBarHiding.h
//  NetJets
//
//  Created by NetJets on 10/9/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface UIViewController (NJNavigationBarHiding)
@property (nonatomic, assign) BOOL hidesNavigationOnScroll;
@property (nonatomic, assign) BOOL hidesToolbarOnScroll;
@property (nonatomic, assign) BOOL hidesStatusBarOnScroll;
@end

@protocol NJOPStatusBarVisibilitySettableViewController <NSObject>
-(void)setPrefersStatusBarHidden:(BOOL)hidden;
-(BOOL)prefersStatusBarHidden;
@end


@protocol NJOPHidingAdapterScrollViewContorller <NSObject>
-(UIScrollView*)njop_scrollView;
@end
@interface UITableViewController (NJOPHidingAdapterScrollViewContorller) <NJOPHidingAdapterScrollViewContorller>
@end

@interface UICollectionViewController (NJOPHidingAdapterScrollViewContorller) <NJOPHidingAdapterScrollViewContorller>
@end
