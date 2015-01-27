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
		destVC.title = @"Privacy and Terms";
	} else if ([segue.identifier isEqualToString:@"aboutSegue"]) {
		UIViewController *destVC = segue.destinationViewController;
		destVC.title = @"About this App";
	}
}

- (IBAction)sendFeedbackTapped:(id)sender
{
	
}

- (IBAction)logoutTapped:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NJOPLoginViewController *loginVC = [storyboard instantiateInitialViewController];
    
    [self.navigationController presentViewController:loginVC animated:YES completion:^{
        [[NJOPOAuthClient sharedInstance] resetCredential];
    }];
    
//    
//    [self dismissViewControllerAnimated:YES completion:^{
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
