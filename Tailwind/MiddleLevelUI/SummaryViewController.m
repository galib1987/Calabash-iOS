//
//  SummaryViewController.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/13/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "SummaryViewController.h"
#import "NJSummaryViewTopHeaderView.h"

@interface SummaryViewController ()

@end

@implementation SummaryViewController
-(void)loadDataSource {
	NSArray* sections = @[
												@{ kSimpleDataSourceSectionsTitleKey : @"TODAY",
//													 kSimpleDataSourceSectionCellsKey : @[
//															 @{
//																 kSimpleDataSourceCellIdentifierKey	: @"NJTodayCell",
//																 kSimpleDataSourceCellKeypaths			 	: @{
//																		 @"mainTextLabel.text" : @"Your car service form 200 hudson street to Landmark Aviation at Tereboro Airport is scheduled to arrive at 11:00\n\n\nEverything is on track for you 12:00 flight to Naples in your Cessna Citation Encore+",
//																		 }
//																 },
//															 @{
//																 kSimpleDataSourceCellIdentifierKey	: @"ActionButtonCell",
//																 kSimpleDataSourceCellKeypaths					: @{
//																		 @"titleLabel.text" : @"CONTACT DRIVER",
//																		 },
//																 },
//															 @{
//																 kSimpleDataSourceCellIdentifierKey	: @"ActionButtonCell",
//																 kSimpleDataSourceCellKeypaths					: @{
//																		 @"titleLabel.text" : @"VIEW FLIGHT INFO",
//																		 },
//																 kSimpleDataSourceCellSegueAction : @"showTodaysFlight"
//																 }
//															 ],
													 },
												@{
													kSimpleDataSourceSectionsTitleKey : @"FORCASETED WEATHER",
													kSimpleDataSourceSectionCellsKey : @[
//															@{
//																kSimpleDataSourceCellIdentifierKey		: @"TodayWeatherCell",
//																kSimpleDataSourceCellKeypaths					: @{
//																		@"leftDateLabel.text" : @"Mon, Aug 28, 2014",
//																		@"leftLocationLabel.text" : @"Tereboro, NJ",
//																		@"leftTimeLabel.text" : @"12:00PM EST",
//																		@"leftTemperatureLabel.text" : @"68º",
//
//																		@"rightDateLabel.text" : @"Mon, Aug 28, 2014",
//																		@"rightLocationLabel.text" : @"Naples, FL",
//																		@"rightTimeLabel.text" : @"2:45PM EST",
//																		@"rightTemperatureLabel.text" : @"75º",
//																		}
//																}
															]
													},
												@{
													kSimpleDataSourceSectionsTitleKey : @"UPCOMING",
													kSimpleDataSourceSectionCellsKey : @[
//															@{
//																kSimpleDataSourceCellIdentifierKey	: @"NJTodayCell",
//																kSimpleDataSourceCellKeypaths			 	: @{
//																		@"mainTextLabel.text" : @"Your next flight from Naples to Tereboro is confirmed for September 30 at 12:00PM",
//																		}
//																},
//															@{
//																kSimpleDataSourceCellIdentifierKey	: @"ActionButtonCell",
//																kSimpleDataSourceCellKeypaths					: @{
//																		@"titleLabel.text" : @"VIEW FLIGHTS",
//																		},
//																kSimpleDataSourceCellSegueAction : @"showAllFlights"
//																}
															]
													}
												];

	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd MMM, YYYY"];
	NSString* dateString = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@"\n Welcome My Smith"];

	self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
	self.dataSource.headerFooterCellIdentifiers = @[@"SummaryHeaderView"];
	[self.dataSource setConfigureHeaderFooterViewBlock:^(UIView *headerView) {
		if ([headerView isKindOfClass:[NJSummaryViewTopHeaderView class]]) {
			NJSummaryViewTopHeaderView* tableHeaderView = (NJSummaryViewTopHeaderView*)headerView;
			tableHeaderView.topLabelView.text = dateString;
			tableHeaderView.bodyLabelView.text = @"Hello Ms. Smith";
			[tableHeaderView layoutIfNeeded];
		}
	}];

}
@end
