//
//  NJOPNavigationController.m
//  Tailwind
//
//  Created by netjets on 2/2/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPNavigationController.h"

@interface NJOPNavigationController ()

@end

@implementation NJOPNavigationController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBack) name:goBackSubScreen object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    NSString *viewControllerID = viewController.restorationIdentifier;
    UIStoryboard *st = viewController.storyboard;
    NSString *storyboardName = [st valueForKey:@"name"];
    if (viewControllerID == nil || [viewControllerID length] < 1) {
        viewControllerID = @"unknown";
    }
    if (storyboardName == nil || [storyboardName length] < 1) {
        storyboardName = @"unknown";
    }
    NSLog(@"pushViewController: %@ / %@", viewControllerID,storyboardName);
    if ([self.delegate respondsToSelector:@selector(pushScreen:)]) {
        NSDictionary *nsd = [NSDictionary dictionaryWithObjectsAndKeys:storyboardName,menuStoryboardName,viewControllerID,menuViewControllerName, [NSNumber numberWithBool:YES],menuIsSubScreen, nil];
        [self.delegate pushScreen:nsd];
    }

}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    NSLog(@"popViewController");
    return [super popViewControllerAnimated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - custom methods
- (void) goBack {
    [self popViewControllerAnimated:YES];
}


@end
