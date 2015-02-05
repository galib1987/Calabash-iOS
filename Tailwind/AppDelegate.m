//
//  AppDelegate.m
//  Tailwind
//
//  Created by Ryan Smith on 9/29/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "AppDelegate.h"
//#import "NJOPHomeViewController.h"
#import "NJOPAirportPM.h"
#import "NCLAppOverlayWindow.h"
#import "NJOPConfig.h"

#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // set NCL framework log level
    [NCLFramework setLogLevel:LogLevelINFO];
    
    // setup global http headers for all http calls to netjets.com
    NSMutableDictionary *projectHeaders = [[NSMutableDictionary alloc] initWithDictionary:[[NCLNetworking sharedInstance] appHeaders]];
    [projectHeaders setObject:API_SOURCE_IDENTIFIER forKey:@"AppAgent"];
    [[NCLNetworking sharedInstance] setStandardHeaders:projectHeaders forDomain:@"netjets.com"];
    
//    [NJOPAirportPM sharedInstance].mainMOC;
	
    // Override point for customization after application launch.
    // some config items
    NJOPConfig *conf = [NJOPConfig sharedInstance];
    conf.loadStaticJSON = USE_STATIC_DATA; // see if we're just loading static JSON or not
    
    self.currentStoryboardTypeInt = isUndefinedScreen; // set the screen as unknown at first
    self.selectedReservation = nil;
    self.shouldClearHistory = [NSNumber numberWithInt:1];

    // listen for major menu changes
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goChangeScreen:) name:changeScreen object:nil];
    // listen for releasing the keyboard focus
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:dismissKeyboard object:nil];
	
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
	

    // let's see if we need to show welcome screen
//    if ([[NJOPConfig sharedInstance] shouldSeeWelcomeScreen] == YES) {
//        NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Welcome",menuStoryboardName,@"WelcomeRootVC",menuViewControllerName,[NSNumber numberWithBool:YES],menuShouldHideMenu, nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif];
//    }
	
	
	//
	MainTabBarController *mainController = [[MainTabBarController alloc] init];
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = mainController;
	[self.window makeKeyAndVisible];

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
    
    // NOTE: we have added a container storyboard for most screens except for
    //       Welcome screen
    //       Login screen
    // for the container storyboard, instead of navigation controller, it's a container viewController
    
    NSString *storyboard = [[aNotification userInfo] objectForKey:menuStoryboardName];
    NSString *viewController = [[aNotification userInfo] objectForKey:menuViewControllerName];
    NSNumber *shouldDisplayMenu = [[aNotification userInfo] objectForKey:menuShouldHideMenu];
    NSNumber *storyboardType = [[aNotification userInfo] objectForKey:appStoryboardIdentifier];
    self.shouldClearHistory =[[aNotification userInfo] objectForKey:containerShouldClearHistory];
    self.selectedReservation = [[aNotification userInfo] objectForKey:requestedReservationObject]; // this will get deprecated once we have CoreData
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:viewController];
    
    
    
    // we have some cases here
    if (storyboardType == nil) {
        storyboardType = [NSNumber numberWithInt:isUndefinedScreen];
    }
    int storyboardTypeInt = [storyboardType intValue];
    BOOL needsNavController = NO;
    BOOL needsMenuController = NO;
    
    switch (storyboardTypeInt) {
        case isContainerScreen:
            // for the container screen
            needsNavController = NO;
            needsMenuController = NO;
            break;
        case isWelcomeScreen:
            needsNavController = YES;
            needsMenuController = NO;
            break;
        case isLoginScreen:
            needsNavController = YES;
            needsMenuController = NO;
            break;
        default:
            // assuming it's the login screen
            needsNavController = YES;
            needsMenuController = NO;
            break;
    }
    
    // see if we need to create a navigation controller
    if (needsNavController == YES) {
        // also, we're going to create a navigation controller
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:vc];
        self.window.rootViewController=navController;
        self.currentStoryboardTypeInt = storyboardTypeInt;
        self.containerVC = nil; // we're going to clear the container viewController
    } else {
        // we don't need navigation controller, and probably it's a container view
        if (storyboardTypeInt == isContainerScreen) {
            self.subStoryboardName = storyboard;
            self.subViewControllerName = viewController;
            // we're going to replace main storyboard and firVieController for the container
            mainStoryboard = [UIStoryboard storyboardWithName:@"Container" bundle:nil];
            if (self.containerVC == nil) {
                self.containerVC = (NJOPContainerHolderViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"MainContainerVC"];
                self.containerVC.delegate = self;
            }
            // let's see if we're already here
            if (self.currentStoryboardTypeInt != isContainerScreen) {
                self.window.rootViewController = self.containerVC;
                self.currentStoryboardTypeInt = isContainerScreen;
                self.shouldClearHistory = [NSNumber numberWithInt:1];
            } else {
                [self notifySubStoryboard];
            }
            
            
        } else {
            self.window.rootViewController = vc;
            self.currentStoryboardTypeInt = storyboardTypeInt;
            self.containerVC = nil; // we're going to clear the container viewController
        }
    }
    
}

- (void) hideKeyboard:(NSNotification *)aNotification {
    [self.window.rootViewController.view endEditing:YES];
}


#pragma mark - NJOPFullPageViewController Delegate
- (void) notifySubStoryboard {
    // sorry! we're going to use NSNotification here to load in the sub VCs
    NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:self.subStoryboardName,menuStoryboardName,self.subViewControllerName,menuViewControllerName,[NSNumber numberWithBool:YES],menuShouldHideMenu, self.shouldClearHistory, containerShouldClearHistory, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:changeSubScreen object:self userInfo:notif];
    //NSLog(@"change sub screen");
}

@end
