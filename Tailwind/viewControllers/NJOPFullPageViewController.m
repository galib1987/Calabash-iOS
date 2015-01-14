//
//  NJOPFullPageViewController.m
//  Tailwind
//
//  Created by netjets on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPFullPageViewController.h"
#import "NJOPWelcomeContentController.h"
#import "NJOPWelcomeRootController.h"

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
    // overlay page indicator on scroll view
    if ([self.view.subviews count] == 2) {
        for(UIView* t in self.view.subviews) {
            if([t isKindOfClass:[UIScrollView class]]) {
                self.scrollView = (UIScrollView*)t;
                self.scrollView.frame = self.view.bounds;
                self.scrollView.delegate = self;
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat viewWidth = self.view.frame.size.width;
    
    self.offset = scrollView.contentOffset.x-viewWidth;
    
    [((NJOPWelcomeRootController *)self.parentViewController) handleScroll];
}

@end
