//
//  AppDelegate.m
//  Tailwind
//
//  Created by Ryan Smith on 9/29/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "AppDelegate.h"
//#import "NJOPHomeViewController.h"

#import "NCLAppOverlayWindow.h"
#import "NJOPConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
//    NJOPHomeViewController *vc = [storyboard instantiateInitialViewController];
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = vc;
//    [self.window makeKeyAndVisible];

    // listen for major menu changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goChangeScreen:) name:changeScreen object:nil];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    // see if we need to load the welcome screen

    // let's see if we need to show welcome screen
    if ([[NJOPConfig sharedInstance] shouldSeeWelcomeScreen] == YES) {
        NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Welcome",menuStoryboardName,@"WelcomeRootVC",menuViewControllerName,[NSNumber numberWithBool:YES],menuShouldHideMenu, nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif];
    }
    
    // TEST CODE TO DISPLAY BOOKING ON LAUNCH vvvvv
    //NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Booking",menuStoryboardName,@"BookingSelectAccount",menuViewControllerName, nil];
    //[[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif]; // using NSNotifications for menu changes because we also need to do other things in other places
    // TEST CODE TO DISPLAY BOOKING ON LAUNCH ^^^^^

    // let's see if we need to show welcome screen
    if ([[NJOPConfig sharedInstance] shouldSeeWelcomeScreen] == YES) {
        NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Welcome",menuStoryboardName,@"WelcomeRootVC",menuViewControllerName,[NSNumber numberWithBool:YES],menuShouldHideMenu, nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) goChangeScreen:(NSNotification *) aNotification {
    
    NSString *storyboard = [[aNotification userInfo] objectForKey:menuStoryboardName];
    NSString *viewController = [[aNotification userInfo] objectForKey:menuViewControllerName];
    NSNumber *shouldDisplayMenu = [[aNotification userInfo] objectForKey:menuShouldHideMenu];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:viewController];
    
    
    // also, we're going to create a navigation controller
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:vc];
    //[[UIApplication sharedApplication].keyWindow setRootViewController:vc];
    self.window.rootViewController=navController;
    
    if (self.njopMenuViewController == nil) {
    
        // we're also adding the global menu to all the storyboards
        self.njopMenuViewController = [[NJOPMenuViewController alloc] initWithNibName:@"NJOPMenuViewController" bundle:nil];
        
    }

    UIView *parentView = [self.window.rootViewController.view superview];
    // see if we need to hide menu
    if ([shouldDisplayMenu intValue] < 1) {
        [parentView addSubview:self.njopMenuViewController.view];
        [parentView bringSubviewToFront:self.njopMenuViewController.view];
    }

    
    
}

@end
