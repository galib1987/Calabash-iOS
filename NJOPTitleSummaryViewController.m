//
//  NJOPTitleSummaryViewController.m
//  Tailwind
//
//  Created by netjets on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPTitleSummaryViewController.h"

@interface NJOPTitleSummaryViewController ()

@end

@implementation NJOPTitleSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    float summaryHeight = 44.0;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    self.screenWidth = screenSize.width;
    self.screenHeight = screenSize.height;
    float y = self.screenHeight - self.navigationController.navigationBar.frame.size.height;
    self.view.frame = CGRectMake(0.0, y, self.screenWidth, summaryHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)openRequestsPressed:(id)sender {
    NSLog(@"EXPAND PRESSED.");
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
