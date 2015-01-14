//
//  NJOPWelcomeRootController.m
//  Tailwind
//
//  Created by netjets on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPWelcomeRootController.h"
#import "NJOPConfig.h"

@interface NJOPWelcomeRootController ()

@end

@implementation NJOPWelcomeRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // get Items from Json File
    [self getWelcomeItems];
    [self.navigationController setNavigationBarHidden:YES];
    
    // Do any additional setup after loading the view.
    
    // Create page view controller
    self.pageViewController = [[NJOPFullPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    // set delegates
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    // Add pages
    NJOPWelcomeContentController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    // Add to view
    [self.pageViewController willMoveToParentViewController:self];
    [self addChildViewController:self.pageViewController];
    [self.view insertSubview:self.pageViewController.view atIndex:1]; // behind skip button, in front of bg
    [self.pageViewController didMoveToParentViewController:self];
    
    // Tell first page that it has displayed
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
    
    // Set page items
    welcomeContentViewController.imageFile = self.items[index][@"pageBgs"];
    welcomeContentViewController.headerText = self.items[index][@"pageHeaders"];
    welcomeContentViewController.descText = self.items[index][@"pageDescs"];
    if (self.items[index][@"hasButtons"]) {
        welcomeContentViewController.showButtons = true;
        welcomeContentViewController.buttonAText = self.items[index][@"buttonA"];
        welcomeContentViewController.buttonBText = self.items[index][@"buttonB"];
    }
    welcomeContentViewController.pageIndex = index;
    
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
    self.nextPage = (NJOPWelcomeContentController *)[pendingViewControllers objectAtIndex:0];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.pageViewController.currentPage = (int)[[self.pageViewController.viewControllers objectAtIndex:0] pageIndex];
    [(NJOPWelcomeContentController *)[self.pageViewController.viewControllers objectAtIndex:0] didFinishDisplay];
    [self.displayedItems setObject:@(true) atIndexedSubscript:self.pageViewController.currentPage];
}

- (void)handleScroll {
    CGFloat offset = self.pageViewController.currentPage*self.view.frame.size.width+self.pageViewController.offset;
    CGFloat percentage = offset/(self.totalPages*self.view.frame.size.width);
    
    CGFloat bgOffscreenWidth = self.bgImage.frame.size.width - self.view.frame.size.width;
    [self.bgImage setFrame:CGRectOffset(self.bgImage.bounds, (percentage*-200)-bgOffscreenWidth/2, 0)];
    
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
    [[NJOPConfig sharedInstance] hasSeenWelcomeScreen];
    NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Main",menuStoryboardName,@"LoginVC",menuViewControllerName,[NSNumber numberWithBool:YES],menuShouldHideMenu, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif];
}
@end
