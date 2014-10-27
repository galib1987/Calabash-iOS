//
//  FlightDetailViewController.m
//  Tailwind
//
//  Created by Amos Elmaliah on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "FlightDetailViewController.h"
#import "WeatherCell.h"
#import "FBOCell.h"
#import "TailCell.h"
#import "FlightDetailTopHeaderView.h"
#import "NJCellBackgroundView.h"
#import "ReservationHeaderView.h"

@interface FlightDetailViewController ()
@property (nonatomic, strong) NSArray* sections;
@end

@implementation FlightDetailViewController

- (IBAction)shareAction:(id)sender {
	
	UIActivityViewController* activityController = [[UIActivityViewController alloc] initWithActivityItems:@[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypeAirDrop] applicationActivities:@[]];
	
	
	if ([activityController respondsToSelector:@selector(setCompletionWithItemsHandler:)]) {
		[activityController setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
			
		}];
	} else if([activityController respondsToSelector:@selector(setCompletionHandler:)]) {
		
	 [activityController setCompletionHandler:^(NSString *activityType, BOOL completed) {
		 
		}];
 }
	[self presentViewController:activityController animated:YES completion:^{
		
	}];
}

static NSString* headerIdentifier = @"ReservationHeaderView";

-(void)loadDataSource {

	//UIImage* image = [UIImage imageNamed:@"sun"];

	NSArray* sections = @[
												@{
													kSimpleDataSourceSectionsHeaderKeyapthsKey 	: @{
															@"titleLabel.text" : @"Reservation: 123214 (2 Legs)"
															},
													 kSimpleDataSourceSectionsHeaderIdentifierKey : headerIdentifier,
													 kSimpleDataSourceSectionCellsKey : @[
															 @{
																 kSimpleDataSourceCellIdentifierKey			: @"FBOCell",
																 kSimpleDataSourceCellKeypaths			 		: @{
//																		 @"locationLabel.text" : @"Teretborogh, NJ",
//																		 @"numberLabel.text" : @"KTEB",
//																		 @"timeLabel.text" : @"12:00 PM EST",
//																		 @"directionLabel.text" : @"Departing FBO",
//																		 @"airportNameLabel.text" : @"Landmark Aviation",
//																		 @"airportAddressLabel.text" : @"101 Charles Lindbergh Dr.",
//																		 @"phoneNumberLabel.text" : @"123.543.1234",
																		 }
																 },
															 @{
																 kSimpleDataSourceCellIdentifierKey			: @"FBOCell",
																 kSimpleDataSourceCellKeypaths			 		: @{
//																		 @"locationLabel.text" : @"Naples, FL",
//																		 @"numberLabel.text" : @"KAPF",
//																		 @"timeLabel.text" : @"2:45 PM EST",
//																		 @"directionLabel.text" : @"Arriving FBO",
//																		 @"airportNameLabel.text" : @"Naples Airport Authority",
//																		 @"airportAddressLabel.text" : @"100 Aivation Drive North",
//																		 @"phoneNumberLabel.text" : @"123.543.1234",
																		 }
																 },
															 @{
																 kSimpleDataSourceCellIdentifierKey		: @"WeatherCell",
																 kSimpleDataSourceCellKeypaths				: @{
//																		 @"dateLabel.text" : @"Mon, Aug 28, 2014",
//																		 @"firstLocationLabel.text" : @"Teterboro, NJ",
//																		 @"firstTimeLabel.text" : @"12:00PM EST",
//																		 @"firstTemperatureLabel.text" : @"68º",
//																		 @"firstImageView.image" : image,
//
//																		 @"secondLocationLabel.text" : @"Mon, Aug 28, 2014",
//																		 @"secondTimeLabel.text" : @"12:00PM EST",
//																		 @"secondTemperatureLabel.text" : @"68º",
//																		 @"secondImageView.image" : image,
																		 }
																 },
															 @{
																 kSimpleDataSourceCellIdentifierKey			: @"InfoCell",
																 kSimpleDataSourceCellKeypaths					: @{
																		 @"topLabel.text" : @"Your Plane",
																		 @"detailLabel.text" : @"Cessna Citation Encore+",
																		 //																@"imgaeView" : @"",
																		 }
																 },
															 @{
																 kSimpleDataSourceCellIdentifierKey			: @"InfoCell",
																 kSimpleDataSourceCellKeypaths					: @{
																		 @"topLabel.text" : @"Ground Transportation",
																		 @"detailLabel.text" : @"Requested",
																		 //																@"imgaeView" : @"",
																		 }
																 },
															 @{
																 kSimpleDataSourceCellIdentifierKey			: @"InfoCell",
																 kSimpleDataSourceCellKeypaths					: @{
																		 @"topLabel.text" : @"Your Crew",
																		 @"detailLabel.text" : @"Captain Brad Hanshaw",
																		 //																@"imgaeView" : @"",
																		 }
																 },
															 @{
																 kSimpleDataSourceCellIdentifierKey			: @"InfoCell",
																 kSimpleDataSourceCellKeypaths					: @{
																		 @"topLabel.text" : @"Passenger Manifest",
																		 @"detailLabel.text" : @"2 Passengers",
																		 //																@"imgaeView" : @"",
																		 }
																 },
															 @{
																 kSimpleDataSourceCellIdentifierKey			: @"InfoCell",
																 kSimpleDataSourceCellKeypaths					: @{
																		 @"topLabel.text" : @"Catering",
																		 @"detailLabel.text" : @"Requested",
																		 //																@"imgaeView" : @"",
																		 }
																 },
															 @{
																 kSimpleDataSourceCellIdentifierKey			: @"InfoCell",
																 kSimpleDataSourceCellKeypaths					: @{
																		 @"topLabel.text" : @"Advisory Notes",
																		 @"detailLabel.text" : @"Please Read",
																		 //																@"imgaeView" : @"",
																		 }
																 },
															 ],
													 },
												];
	self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
	self.dataSource.headerFooterCellIdentifiers = @[headerIdentifier];
	self.dataSource.title = @"FLIGHT DETAILS";
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[self.navigationController.navigationBar setBarTintColor:DARK_BACKGROUND_COLOR];

//	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//	[formatter setDateFormat:@"dd MMM, YYYY"];
//	NSString* dateString = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@"\n Welcome My Smith"];
//	FlightDetailTopHeaderView* tableHeaderView = (FlightDetailTopHeaderView*)self.tableView.tableHeaderView;
	//	tableHeaderView.topLabelView.text = dateString;
	//	tableHeaderView.bodyLabelView.text = @"Hello Ms. Smith";
//	[tableHeaderView layoutIfNeeded];
}

@end
