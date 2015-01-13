//
//  NJOPOSViewController.m
//  Tailwind
//
//  Created by netjets on 1/12/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPOSViewController.h"

@interface NJOPOSViewController ()

@end

@implementation NJOPOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureSlider];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureSlider {
    self.latenessSlider.minimumValue = 1;
    self.latenessSlider.maximumValue = 60;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sliderChanged:(id)sender {
    int intValue = (int)ceil(self.latenessSlider.value);
    [_latenessNotificationButton setTitle:[NSString stringWithFormat:@"I'LL BE %d MINUTES LATE", intValue] forState:UIControlStateNormal];
    
}

@end
