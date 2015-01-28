//
//  NJOPDisplayUnitsViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPDisplayUnitsViewController.h"

#import "NJOPSettingsManager.h"

@interface NJOPDisplayUnitsViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation NJOPDisplayUnitsViewController

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"unitCell"];
	
	NJOPSettingsManager *manager = [NJOPSettingsManager sharedInstance];
	
	switch (indexPath.row) {
		case 0:
		{
			cell.textLabel.text = @"Date";
			cell.detailTextLabel.text = manager.dateFormatDisplay;
		}
			break;
			
		case 1:
		{
			cell.textLabel.text = @"Time";
			cell.detailTextLabel.text = nil;//manager.dateFormatDisplay;
		}
			break;
			
		case 2:
		{
			cell.textLabel.text = @"Temperature";
			cell.detailTextLabel.text = nil;//manager.dateFormatDisplay;
		}
			break;
			
		case 3:
		{
			cell.textLabel.text = @"Distance";
			cell.detailTextLabel.text = nil;//manager.dateFormatDisplay;
		}
			break;
			
		default:
			break;
	}
	
	return nil;
}

@end
