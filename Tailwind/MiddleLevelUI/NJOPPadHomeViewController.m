//
//  NJOPPadHomeViewController.m
//  Tailwind
//
//  Created by netjets on 12/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPPadHomeViewController.h"

@interface NJOPPadHomeViewController ()

- (void) checkSession;
- (void) includeHomeScreen;
- (void) showScreen:(NSNotification *)aNotification;

@end

@implementation NJOPPadHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showScreen:) name:changeScreen object:nil];
    [self checkSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) checkSession {
    BOOL session = NO;
    if (session == NO) {
        [self performSegueWithIdentifier:@"goToLoginScreen" sender:self];
    } else {
        [self includeHomeScreen];
    }
}

- (void) includeHomeScreen {
    
}

- (void) showScreen:(NSNotification *)aNotification {
    NSString *screenName = [[aNotification userInfo] objectForKey:@"screen"];
    if ([screenName isEqualToString:goToLoginScreen]) {
        
    }
    if ([screenName isEqualToString:goToHomeScreen]) {
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
