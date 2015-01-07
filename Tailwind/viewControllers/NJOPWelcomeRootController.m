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
    
    // get Items from Json File
    [self getWelcomeItems];
    
    // Do any additional setup after loading the view.
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
    
    
    /*[self.pageViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *pageViewControllerWidth = [NSLayoutConstraint constraintWithItem:self.pageViewController attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *pageViewControllerHeight = [NSLayoutConstraint constraintWithItem:self.pageViewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *pageViewControllerX = [NSLayoutConstraint constraintWithItem:self.pageViewController attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *pageViewControllerY = [NSLayoutConstraint constraintWithItem:self.pageViewController attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:pageViewControllerWidth];
    [self.view addConstraint:pageViewControllerHeight];
    [self.view addConstraint:pageViewControllerX];
    [self.view addConstraint:pageViewControllerY];
    NSLog(@"port HEIGHT: %f; controller height: %f", self.view.frame.size.height, self.pageViewController.view.frame.size.height);*/
    
    [(NJOPWelcomeContentController *)[self.pageViewController.viewControllers objectAtIndex:0] didFinishDisplay];
    
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

-(void)getWelcomeItems{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"welcome-items" ofType:@"json"]];
    NSDictionary* welcomeItems = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.items = welcomeItems[@"items"];
    self.totalPages = (int)[self.items count];
    self.displayedItems = [[NSMutableArray alloc] init];
    [self.displayedItems addObject:@(true)];
}

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
    
    welcomeContentViewController.imageFile = self.items[index][@"pageBgs"];
    welcomeContentViewController.headerText = self.items[index][@"pageHeaders"];
    welcomeContentViewController.descText = self.items[index][@"pageDescs"];
    if (self.items[index][@"hasButtons"]) {
        welcomeContentViewController.showButtons = true;
        welcomeContentViewController.buttonAText = self.items[index][@"buttonA"];
        welcomeContentViewController.buttonBText = self.items[index][@"buttonB"];
    }
    welcomeContentViewController.pageIndex = index;
    // NSLog(@"%@", self.items[index][@"pageBgs"]);
    
    if (index < self.displayedItems.count && self.displayedItems[index]) {
        welcomeContentViewController.displayed = true;
    }
    
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
    [(NJOPWelcomeContentController *)[self.pageViewController.viewControllers objectAtIndex:0] didFinishDisplay];
    [self.displayedItems setObject:@(true) atIndexedSubscript:self.pageViewController.currentPage];
}

- (void)handleScroll {
    CGFloat offset = self.pageViewController.currentPage*self.view.frame.size.width+self.pageViewController.offset;
    CGFloat percentage = offset/(self.totalPages*self.view.frame.size.width);
    /*CGRect offsetBounds = self.bgImage.bounds;
     offsetBounds.origin.x = offset*-0.2;
     self.bgImage.bounds = offsetBounds;*/
    CGFloat bgOffscreenWidth = self.bgImage.frame.size.width - self.view.frame.size.width;
    [self.bgImage setFrame:CGRectOffset(self.bgImage.bounds, (percentage*-200)-bgOffscreenWidth/2, 0)];
    //NSLog(@"%f", percentage);
    
    [[self.pageViewController.viewControllers objectAtIndex:0] handleScroll:self.pageViewController.offset];
    if (self.nextPage && self.nextPage.pageIndex != self.pageViewController.currentPage) {
        if (self.pageViewController.offset < 0) {
            [self.nextPage handleScroll:self.view.frame.size.width+self.pageViewController.offset];
        } else {
            [self.nextPage handleScroll:self.pageViewController.offset-self.view.frame.size.width];
        }
    }
}

- (IBAction)skipButton:(id)sender {
}
@end
