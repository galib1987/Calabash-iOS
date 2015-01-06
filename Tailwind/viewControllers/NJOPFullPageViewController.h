//
//  NJOPFullPageViewController.h
//  Tailwind
//
//  Created by netjets on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJOPFullPageViewController : UIPageViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property CGFloat offset;

@end
