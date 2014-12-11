//
//  AppDelegate.m
//  Tailwind
//
//  Created by Ryan Smith on 9/29/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	[[[UIToolbar class] appearance] setBarTintColor:TOOLBAR_BACKGROUND_COLOR];
	[[[UIToolbar class] appearance] setTintColor:NAVIGATIONBAR_TINT_COLOR];

#if DEBUG
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	NSLog(@"%@", basePath);
#endif
    [[BITHockeyManager sharedHockeyManager] configureWithBetaIdentifier:@"1a9ff05871bc3ef4723175826474142f"
                                                         liveIdentifier:@""
                                                               delegate:self];
    
    // app id for iOS8 testing
    //    [[BITHockeyManager sharedHockeyManager] configureWithBetaIdentifier:@"c01b8990389d65772ab8dd9e942aba09"
    //                                                         liveIdentifier:@"97fdbf186cc09f3ebb773582a94292a0"
    //                                                               delegate:self];
    
    // automatically send report without user interaction
    [[[BITHockeyManager sharedHockeyManager] crashManager] setCrashManagerStatus:BITCrashManagerStatusAutoSend];
    [[BITHockeyManager sharedHockeyManager] startManager];
    // Override point for customization after application launch.
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

@end
