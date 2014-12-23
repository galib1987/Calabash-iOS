//
//  NJOPWelcomeRootController.h
//  Tailwind
//
//  Created by netjets on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPWelcomeContentController.h"

@interface NJOPWelcomeRootController : UIViewController <UIPageViewControllerDataSource>
- (IBAction)skipButton:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageBgs;
@property (strong, nonatomic) NSArray *pageHeaders;
@property (strong, nonatomic) NSArray *pageDescs;

@end
