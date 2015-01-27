//
//  NJOPSettingsTableViewController.m
//  Tailwind
//
//  Created by netjets on 12/20/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPSettingsTableViewController.h"
#import "NJOPLoginViewController.h"
#import "NJOPOAuthClient.h"

@interface NJOPSettingsTableViewController ()

- (IBAction)sendFeedbackTapped:(id)sender;
- (IBAction)logoutTapped:(id)sender;

@end

@implementation NJOPSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"unitsSegue"]) {
		
	} else if ([segue.identifier isEqualToString:@"privacySegue"]) {
		UIViewController *destVC = segue.destinationViewController;
		destVC.title = @"PRIVACY AND TERMS";
	} else if ([segue.identifier isEqualToString:@"aboutSegue"]) {
		UIViewController *destVC = segue.destinationViewController;
		destVC.title = @"ABOUT THIS APP";
	}
}

- (IBAction)sendFeedbackTapped:(id)sender
{
	[self performSegueWithIdentifier:@"feedbackSegue" sender:nil];
}

- (IBAction)logoutTapped:(id)sender {
	
	__weak NJOPSettingsTableViewController *weakSelf = self;
	
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
																			 message:@"Are you sure you want to log out?"
																	  preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"GO BACK"
														style:UIAlertActionStyleDefault
													  handler:^(UIAlertAction *action) {
														  //
													  }]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"YES"
														style:UIAlertActionStyleDefault
													  handler:^(UIAlertAction *action) {
														  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
														  NJOPLoginViewController *loginVC = [storyboard instantiateInitialViewController];
														  
														  [weakSelf.navigationController presentViewController:loginVC animated:YES completion:^{
															  [[NJOPOAuthClient sharedInstance] resetCredential];
														  }];
													  }]];
	[self presentViewController:alertController animated:YES completion:^{
		//
	}];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
