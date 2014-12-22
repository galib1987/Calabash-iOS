//
//  NJOPWelcomeRootController.m
//  Tailwind
//
//  Created by Angus.Lo on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPWelcomeRootController.h"

@interface NJOPWelcomeRootController ()

@end

@implementation NJOPWelcomeRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageHeaders = @[@"Welcome to NetJets", @"Placeholder", @"Placeholder2", @"Quick Booking", @"Notifications"];
    self.pageDescs = @[@"Let us show you around.", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"You can submit a flight request in just a few taps. Then our Owner Services team will call you to iron out the details.", @"Allow us to notify you of important flight updates, without answering a phone call."];
    self.pageBgs = @[@"UpcomingFlightsMap.png", @"NJOPFleet.png", @"UpcomingFlightsMap.png", @"NJOPFleet.png", @"UpcomingFlightsMap.png"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
    self.pageViewController.dataSource = self;
    
    NJOPWelcomeContentController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:FALSE completion:nil];
    
    //self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:self.pageViewController];
    [self.view insertSubview:self.pageViewController.view atIndex:0];
    [self.pageViewController didMoveToParentViewController:self];
    
    /*UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.backgroundColor = [UIColor clearColor];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((NJOPWelcomeContentController *) viewController).pageIndex;
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((NJOPWelcomeContentController *) viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageHeaders count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NJOPWelcomeContentController *)viewControllerAtIndex:(NSUInteger) index {
    if ([self.pageHeaders count] == 0 || index >= [self.pageHeaders count]) {
        return nil;
    }
    
    NJOPWelcomeContentController *welcomeContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeContentController"];
    welcomeContentViewController.imageFile = self.pageBgs[index];
    welcomeContentViewController.headerText = self.pageHeaders[index];
    welcomeContentViewController.descText = self.pageDescs[index];
    welcomeContentViewController.pageIndex = index;
    
    return welcomeContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pageHeaders count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (IBAction)skipButton:(id)sender {
}
@end
