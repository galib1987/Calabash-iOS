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
    self.totalPages = [self.items count];
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
    welcomeContentViewController.pageIndex = index;
    // NSLog(@"%@", self.items[index][@"pageBgs"]);
    
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
