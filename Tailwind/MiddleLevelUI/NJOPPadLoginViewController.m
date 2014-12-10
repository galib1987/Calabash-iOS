//
//  NJOPPadLoginViewController.m
//  Tailwind
//
//  Created by netjets on 12/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPPadLoginViewController.h"
#import "NJOPClient+Login.h"

@interface NJOPPadLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) id<Task>loginTask;

- (IBAction)submitLogin:(id)sender;
@end

@implementation NJOPPadLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginButton.backgroundColor = [UIColor blackColor];
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

- (IBAction)submitLogin:(id)sender {
    
    //NSDictionary *screen = [NSDictionary dictionaryWithObjectsAndKeys:goToHomeScreen,@"screen", nil];
    //[[NSNotificationCenter defaultCenter] postNotificationName:changeScreen object:self userInfo:screen];
    
    /*
    self.loginTask = [[NJOPClient loginWithUserInputs:self.userInput] continueWithBlock:^id(id result) {
        NJOPLoginViewController* self = wself;
        
        NSError* error = [(id<Task>)result error];
        if (error) {
            self.loginTask = nil;
            [self presentError:error];
            [UIView animateWithDuration:0.2 animations:^{
                [coverView setAlpha:0.0];
            } completion:^(BOOL finished) {
                [coverView removeFromSuperview];
            }];
        } else {
            label.text = @"Done";
            [UIView animateWithDuration:0.2 animations:^{
                [coverView setAlpha:0.0];
            } completion:^(BOOL finished) {
                [coverView removeFromSuperview];
            }];
            NSAssert(self.completionHandler, @"");
            self.completionHandler(self);
        }
        return nil;
    }];
     */

}
@end
