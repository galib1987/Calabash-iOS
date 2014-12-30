//
//  NJOPFullPageViewController.m
//  Tailwind
//
//  Created by Angus.Lo on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPFullPageViewController.h"

@interface NJOPFullPageViewController ()

@end

@implementation NJOPFullPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    if ([self.view.subviews count] == 2) {
        for(UIView* t in self.view.subviews) {
            if([t isKindOfClass:[UIScrollView class]]) {
                UIScrollView* scrollView = (UIScrollView*)t;
                scrollView.frame = self.view.bounds;
            } else if ([t isKindOfClass:[UIPageControl class]]) {
                [self.view bringSubviewToFront:t];
            }
        }
    }
    [super viewDidLayoutSubviews];
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
