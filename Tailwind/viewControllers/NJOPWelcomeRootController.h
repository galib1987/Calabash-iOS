//
//  NJOPWelcomeRootController.h
//  Tailwind
//
//  Created by netjets on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPWelcomeContentController.h"
#import "NJOPFullPageViewController.h"

@interface NJOPWelcomeRootController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
- (IBAction)skipButton:(id)sender;
@property (strong, nonatomic) NJOPFullPageViewController *pageViewController;
@property (strong, nonatomic) NJOPWelcomeContentController *nextPage;
@property (strong, nonatomic) NSArray *pageBgs;
@property (strong, nonatomic) NSArray *pageHeaders;
@property (strong, nonatomic) NSArray *pageDescs;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;


@property (strong, nonatomic) NSArray *items;

@property int totalPages;

- (void)handleScroll;
-(void)getWelcomeItems;

@end
