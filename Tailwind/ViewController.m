//
//  ViewController.m
//  Tailwind
//
//  Created by Ryan Smith on 9/29/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "ViewController.h"
#import "NNNUserDefaultsManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginTapped:(id)sender {
    
    // we check for login
    NSString *username = self.emailField.text;
    NSString *passwordText = self.passwordField.text;
    if ([username length] > 0 && [passwordText length] > 0) {
        // storing it in the keychain in case we need it again
        [[NNNUserDefaultsManager sharedInstance] setUsername:username];
        NCLUserPassword *password = [[NCLUserPassword alloc] initWithUsername:username password:passwordText host:[[NNNUserDefaultsManager sharedInstance] host]];
        [NCLKeychainStorage saveUserPassword:password error:nil];
//        NNNOAuthClient *authClient = [NNNOAuthClient sharedInstance];
//        [authClient requestCredential];
    }
}
@end
