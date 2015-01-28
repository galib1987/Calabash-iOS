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
	
	self.hideCustomBackButton = YES;
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

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}*/

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
