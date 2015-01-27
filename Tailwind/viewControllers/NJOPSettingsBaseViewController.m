//
//  NJOPSettingsBaseViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPSettingsBaseViewController.h"

@interface NJOPSettingsBaseViewController ()

@end

@implementation NJOPSettingsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self.navigationController.navigationBar setTranslucent:YES];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.view.backgroundColor = [UIColor clearColor];
	[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
	self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
	
	UILabel *titleLabel = [[UILabel alloc] init];
	titleLabel.text = self.navigationItem.title;// @"Settings";
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
	[titleLabel sizeToFit];
	
	self.navigationItem.titleView = titleLabel;
	
	UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkg-copy"]];
	bgView.contentMode = UIViewContentModeCenter;
	bgView.frame = self.view.bounds;
	[self.view addSubview:bgView];
	[self.view sendSubviewToBack:bgView];
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

@end
