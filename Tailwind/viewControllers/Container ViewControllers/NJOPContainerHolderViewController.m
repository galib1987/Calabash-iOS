//
//  NJOPContainerHolderViewController.m
//  Tailwind
//
//  Created by netjets on 1/26/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPContainerHolderViewController.h"

@interface NJOPContainerHolderViewController ()

@end

@implementation NJOPContainerHolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goChangeSubScreen:) name:changeSubScreen object:nil];
    self.subScreenHistory = [NSMutableArray array];
    self.reservation = nil;
    [self displayBackButton];

    
    if ([self.delegate respondsToSelector:@selector(notifySubStoryboard)]) {
        [self.delegate notifySubStoryboard];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    // loading in menu
    if (self.njopMenuViewController == nil) {
        
        // we're also adding the global menu to all the storyboards
        self.njopMenuViewController = [[NJOPMenuViewController alloc] initWithNibName:@"NJOPMenuViewController" bundle:nil];
        
    }
    CGRect f = self.menuView.frame;
    self.njopMenuViewController.view.frame = f;
    [self.view addSubview:self.njopMenuViewController.view];
    [self.view bringSubviewToFront:self.njopMenuViewController.view];
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

#pragma mark - subscreen lifecycle

- (void) goChangeSubScreen:(NSNotification *)aNotification {
    //NSLog(@"adding subscreen");
    NSString *storyboard = [[aNotification userInfo] objectForKey:menuStoryboardName];
    NSString *viewController = [[aNotification userInfo] objectForKey:menuViewControllerName];
    NSNumber *shouldDisplayMenu = [[aNotification userInfo] objectForKey:menuShouldHideMenu];
    NSNumber *storyboardType = [[aNotification userInfo] objectForKey:appStoryboardIdentifier];
    NSNumber *shouldClearHistory = [[aNotification userInfo] objectForKey:containerShouldClearHistory];
    if ([shouldClearHistory intValue] > 0) {
        [self.subScreenHistory removeAllObjects];
    }
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:viewController];
    if ([storyboard isEqualToString:@"Flights"] || [storyboard isEqualToString:@"Settings"] || [storyboard isEqualToString:@"Booking"]) {
        UIViewController *viewcont = [mainStoryboard instantiateViewControllerWithIdentifier:viewController];
        vc = [[UINavigationController alloc]initWithRootViewController:viewcont];
    }
    //UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:vc];
    //[[UIApplication sharedApplication].keyWindow setRootViewController:vc];
    //[self.containerView addSubview:vc.view];
    [self updateHeaderLabel:storyboard];
    [self presentSubScreenViewController:vc];
    [self pushViewController:storyboard withVC:viewController];
    [self displayBackButton];
    
}

- (void) presentSubScreenViewController:(UIViewController *)vc {
    //0. Remove the current Detail View Controller showed
    if(self.currentViewController){
        [self removeCurrentSubScreenViewController];
    }
    
    //1. Add the detail controller as child of the container
    [self addChildViewController:vc];
    
    //2. Define the detail controller's view size
    vc.view.frame = [self frameSubScreenViewController];
    vc.view.backgroundColor = [UIColor clearColor];
    
    //3. Add the Detail controller's view to the Container's detail view and save a reference to the detail View Controller
    //[self.containerHolderView addSubview:vc.view];
    [self.basicContainerView addSubview:vc.view];
    self.currentViewController = vc;
    
    //4. Complete the add flow calling the function didMoveToParentViewController
    [vc didMoveToParentViewController:self];
}

- (void) removeCurrentSubScreenViewController {
    
    //1. Call the willMoveToParentViewController with nil
    //   This is the last method where your detailViewController can perform some operations before neing removed
    [self.currentViewController willMoveToParentViewController:nil];
    
    //2. Remove the DetailViewController's view from the Container
    [self.currentViewController.view removeFromSuperview];
    
    //3. Update the hierarchy"
    //   Automatically the method didMoveToParentViewController: will be called on the detailViewController)
    [self.currentViewController removeFromParentViewController];
}

- (CGRect) frameSubScreenViewController {
    //CGRect detailFrame = self.containerHolderView.bounds;
    CGRect detailFrame = self.basicContainerView.bounds;
    
    return detailFrame;
}

- (void) pushViewController:(NSString *) storyboardName withVC:(NSString *) viewControllerName {
    NSDictionary *nsd = [NSDictionary dictionaryWithObjectsAndKeys:storyboardName, menuStoryboardName, viewControllerName, menuViewControllerName, nil];
    [self.subScreenHistory addObject:nsd];
}

- (NSDictionary *) popViewController {
    NSDictionary *last = [[self.subScreenHistory lastObject] copy];
    if (last != nil) {
        [self.subScreenHistory removeLastObject];
    }
    return last;
}

#pragma mark - display methods

- (void) updateHeaderLabel:(NSString *) label {
    self.headerLabel.text = [[NSString stringWithFormat:@"%@", label] uppercaseString];
}

- (void) displayBackButton {
    if ([self.subScreenHistory count] > 1) {
        self.backButton.hidden = NO;
    } else {
        self.backButton.hidden = YES;
    }
}

- (IBAction)goBack:(id)sender {
    NSDictionary *current = [self popViewController]; // this is the current
    NSDictionary *last = [self popViewController]; // this should be the last one
    if (last != nil) {
        NSString *storyboard = [last objectForKey:menuStoryboardName];
        NSString *viewController = [last objectForKey:menuViewControllerName];
        if ([storyboard length] > 0 && [viewController length] > 0) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboard bundle:nil];
            UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:viewController];
            //UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:vc];
            //[[UIApplication sharedApplication].keyWindow setRootViewController:vc];
            //[self.containerView addSubview:vc.view];
            [self updateHeaderLabel:storyboard];
            [self presentSubScreenViewController:vc];
        }
    }
    [self displayBackButton];
    
}
@end
