//
//  NJOPSettingsBaseTableViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPSettingsBaseTableViewController.h"

@interface NJOPSettingsBaseTableViewController ()

@property (nonatomic, strong) UIBarButtonItem *customBackButton;

@end

@implementation NJOPSettingsBaseTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	[self.navigationController.navigationBar setTranslucent:YES];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.view.backgroundColor = [UIColor clearColor];
	[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
	self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
	
	UILabel *titleLabel = [[UILabel alloc] init];
	titleLabel.text = self.navigationItem.title;
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
	[titleLabel sizeToFit];
	
	self.navigationItem.titleView = titleLabel;
	
	UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkg-copy"]];
	bgView.contentMode = UIViewContentModeCenter;
	self.tableView.backgroundView = bgView;
	
	[self.tableView setSeparatorColor:[UIColor lightGrayColor]];
	
	if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
		UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 22.0, 17.0)];
		[backBtn setBackgroundImage:[UIImage imageNamed:@"nav-back-button"] forState:UIControlStateNormal];
		[backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
		self.customBackButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
		[self.navigationItem setLeftBarButtonItem:self.customBackButton];
		self.navigationItem.hidesBackButton = YES;
	}
}

- (void)setHideCustomBackButton:(BOOL)hideCustomBackButton
{
	_hideCustomBackButton = hideCustomBackButton;
	
	if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
		return;
	}
	
	if (hideCustomBackButton) {
		self.navigationItem.leftBarButtonItem = nil;
	} else {
		self.navigationItem.leftBarButtonItem = self.customBackButton;
	}
}

- (void)backBtnTapped
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
