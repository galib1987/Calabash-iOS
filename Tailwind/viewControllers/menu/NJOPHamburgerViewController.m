//
//  NJOPHamburgerViewController.m
//  Tailwind
//
//  Created by David Lin on 1/8/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPHamburgerViewController.h"

@interface NJOPHamburgerViewController ()

@end

@implementation NJOPHamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
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

- (IBAction)homeButtonPressed:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(resetButtonState)]) {
        [self.delegate resetButtonState];
    }
    NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Home",menuStoryboardName,@"HomeViewController",menuViewControllerName, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif]; // using NSNotifications for menu changes because we also need to do other things in other places
}

- (IBAction)accountButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(resetButtonState)]) {
        [self.delegate resetButtonState];
    }
    
    NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Account",menuStoryboardName,@"AccountViewController",menuViewControllerName, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif]; // using NSNotifications for menu changes because we also need to do other things in other places
}

- (IBAction)messagesButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(resetButtonState)]) {
        [self.delegate resetButtonState];
    }
    
    NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Messages",menuStoryboardName,@"MessagesTVC",menuViewControllerName, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif]; // using NSNotifications for menu changes because we also need to do other things in other places
}

- (IBAction)filghtsButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(resetButtonState)]) {
        [self.delegate resetButtonState];
    }
    
    NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Flights",menuStoryboardName,@"FlightsTVC",menuViewControllerName, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif]; // using NSNotifications for menu changes because we also need to do other things in other places
}

- (IBAction)settingsButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(resetButtonState)]) {
        [self.delegate resetButtonState];
    }
    
    NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Settings",menuStoryboardName,@"SettingsTVC",menuViewControllerName, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif]; // using NSNotifications for menu changes because we also need to do other things in other places
}

- (IBAction)bookButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(resetButtonState)]) {
        [self.delegate resetButtonState];
    }
    
    NSDictionary *notif = [NSDictionary dictionaryWithObjectsAndKeys:@"Booking",menuStoryboardName,@"BookingSelectAccount",menuViewControllerName, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:notif]; // using NSNotifications for menu changes because we also need to do other things in other places
}
@end
