//
//  AllFlightsViewController.m
//  TailWinder
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "AllFlightsViewController.h"

@interface AllFlightsViewController ()

@end

@implementation AllFlightsViewController

-(void)registerReusableViews {
	[self.tableView registerNib:[UINib nibWithNibName:@"NJTileContainingTableViewCell"
																						 bundle:nil]
			 forCellReuseIdentifier:@"NJTileContainingTableViewCell"];

}

-(void)loadDataSource {
	NSArray* sections = @[
												@{ kSimpleDataSourceSectionsTitleKey : @"PAST",
//													 kSimpleDataSourceSectionsHeaderIdentifierKey : @"NJAllFlightsHeader",
													 kSimpleDataSourceSectionsHeaderKeyapthsKey : @{
															 @"titleLabel.text" : @"PAST"
															 },
													 },
												@{ kSimpleDataSourceSectionsTitleKey : @"TODAY",
//													 kSimpleDataSourceSectionsHeaderIdentifierKey : @"AllFlightsHeader",
													 kSimpleDataSourceSectionsHeaderKeyapthsKey : @{
															 @"titleLabel.text" : @"TODAY"
															 },
													 kSimpleDataSourceSectionCellsKey : @[
															 @{
																 kSimpleDataSourceCellIdentifierKey	: @"NJTileContainingTableViewCell",
																 kSimpleDataSourceCellKeypaths 			: @{
																		 @"tile.headingLabel.text"		: @"Monday Sept 6, 2014",
																		 @"tile.topLeftLabel.text" 		: @"TETERBORO",
																		 @"tile.bottomLeftLabel.text" : @"12:00 PM EST",
																		 @"tile.topRightLabel.text" 	: @"NAPLES MUN",
																		 @"tile.bottomRightLabel.text" 	: @"2:45 PM EST",
																		 }
																 }
															 ]
													 },
												@{ kSimpleDataSourceSectionsTitleKey : @"UPCOMING",
//													 kSimpleDataSourceSectionsHeaderIdentifierKey : @"AllFlightsHeader",
													 kSimpleDataSourceSectionsHeaderKeyapthsKey : @{
															 @"titleLabel.text" : @"UPCOMING"
															 },
													 }
												];
	self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
	[self.dataSource setHeaderFooterCellIdentifiers:@[@"AllFlightsHeader"]];
}


@end
