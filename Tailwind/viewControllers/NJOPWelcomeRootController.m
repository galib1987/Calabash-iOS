//
//  NJOPWelcomeRootController.m
//  Tailwind
//
//  Created by netjets on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPWelcomeRootController.h"

@interface NJOPWelcomeRootController ()

@end

@implementation NJOPWelcomeRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.totalPages = 5;
    self.pageHeaders = @[@"Welcome to NetJets", @"Flights", @"Your Owner Services Team", @"Quick Booking", @"Notifications"];
    self.pageDescs = @[@"Let us show you around.", @"See all your upcoming flights in one place.", @"Your team is now just a tap away—24 hours a day, seven days a week.", @"You can submit a flight request in just a few taps. Then our Owner Services team will call you to iron out the details.", @"Allow us to notify you of important flight updates, without answering a phone call."];
    self.pageBgs = @[@"welcome0.png", @"welcome1.png", @"welcome2.png", @"welcome3.png", @"welcome4.png"];
    
    /*self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
    self.pageViewController.dataSource = self;
    
    NJOPWelcomeContentController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:FALSE completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view insertSubview:self.pageViewController.view atIndex:0];
    [self.pageViewController didMoveToParentViewController:self];*/
    
    /*UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.backgroundColor = [UIColor clearColor];*/
    
    
    self.pageViewController = [[NJOPFullPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    //self.pageViewController.view.frame = CGRectMake(20, 20, self.view.frame.size.width-40, self.view.frame.size.height-40);
    
    NJOPWelcomeContentController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self.pageViewController willMoveToParentViewController:self];
    [self addChildViewController:self.pageViewController];
    [self.view insertSubview:self.pageViewController.view atIndex:1]; // behind skip button, in front of bg
    [self.pageViewController didMoveToParentViewController:self];
    
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
    if (index == self.totalPages) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NJOPWelcomeContentController *)viewControllerAtIndex:(NSUInteger) index {
    if (index >= self.totalPages) {
        return nil;
    }
    
    NJOPWelcomeContentController *welcomeContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeContentTemplate"];
    welcomeContentViewController.imageFile = self.pageBgs[index];
    welcomeContentViewController.headerText = self.pageHeaders[index];
    welcomeContentViewController.descText = self.pageDescs[index];
    welcomeContentViewController.pageIndex = index;
    //NSLog(@"%@", welcomeContentViewController.pageIndex);
    
    return welcomeContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.totalPages;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    [(NJOPWelcomeContentController *)[pendingViewControllers objectAtIndex:0] transitionIn];
    self.nextPage = (NJOPWelcomeContentController *)[pendingViewControllers objectAtIndex:0];
    //NSLog(@"peeking at %d", ((NJOPWelcomeContentController *)[pendingViewControllers objectAtIndex:0]).pageIndex);
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    //NSLog(@"finished? %d", finished);
    self.pageViewController.currentPage = (int)[[self.pageViewController.viewControllers objectAtIndex:0] pageIndex];
}

- (void)handleScroll {
    CGFloat offset = self.pageViewController.currentPage*self.view.frame.size.width+self.pageViewController.offset;
    /*CGRect offsetBounds = self.bgImage.bounds;
    offsetBounds.origin.x = offset*-0.2;
    self.bgImage.bounds = offsetBounds;*/
    [self.bgImage setFrame:CGRectOffset(self.bgImage.bounds, offset*-0.2, 0)];
    //NSLog(@"%f", self.bgImage.bounds.origin.x);
    [[self.pageViewController.viewControllers objectAtIndex:0] handleScroll:self.view.frame.size.width-self.pageViewController.offset];
    if (self.nextPage && self.nextPage.pageIndex != self.pageViewController.currentPage) {
        [self.nextPage handleScroll:self.pageViewController.offset];
    }
}

- (IBAction)skipButton:(id)sender {
}
@end
