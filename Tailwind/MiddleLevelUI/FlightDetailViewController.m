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

static NSString* kSectionCellsKey = @"cells";
static NSString* kSectionsTitleKey = @"title";
static NSString* kCellIdentifierKey	= @"identifier";
static NSString* kCellKeypaths = @"keypaths";

static NSString* headerIdentifier = @"ReservationHeaderView";

-(NSArray*)createSections {
	
	UIImage* image = [UIImage imageNamed:@"sun"];
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd MMM, YYYY"];
	NSString* dateString = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@"\n Welcome My Smith"];

	return @[
					 @{ kSectionsTitleKey : @"Reservation: 123214 (2 Legs)",
							kSectionCellsKey : @[
									@{
										kCellIdentifierKey	: @"FBOCell",
										kCellKeypaths			 	: @{
												@"locationLabel.text" : @"Teretborogh, NJ",
												@"numberLabel.text" : @"KTEB",
												@"timeLabel.text" : @"12:00 PM EST",
												@"directionLabel.text" : @"Departing FBO",
												@"airportNameLabel.text" : @"Landmark Aviation",
												@"airportAddressLabel.text" : @"101 Charles Lindbergh Dr.",
												@"phoneNumberLabel.text" : @"123.543.1234",
												}
										},
									@{
										kCellIdentifierKey	: @"FBOCell",
										kCellKeypaths			 	: @{
												@"locationLabel.text" : @"Naples, FL",
												@"numberLabel.text" : @"KAPF",
												@"timeLabel.text" : @"2:45 PM EST",
												@"directionLabel.text" : @"Arriving FBO",
												@"airportNameLabel.text" : @"Naples Airport Authority",
												@"airportAddressLabel.text" : @"100 Aivation Drive North",
												@"phoneNumberLabel.text" : @"123.543.1234",
												}
										},
									@{
										kCellIdentifierKey		: @"WeatherCell",
										kCellKeypaths					: @{
												@"dateLabel.text" : @"Mon, Aug 28, 2014",
												
												@"firstLocationLabel.text" : @"Teterboro, NJ",
												@"firstTimeLabel.text" : @"12:00PM EST",
												@"firstTemperatureLabel.text" : @"68º",
												@"firstImageView.image" : image,
												
												@"secondLocationLabel.text" : @"Mon, Aug 28, 2014",
												@"secondTimeLabel.text" : @"12:00PM EST",
												@"secondTemperatureLabel.text" : @"68º",
												@"secondImageView.image" : image,
												}
										},
									@{
										kCellIdentifierKey	: @"InfoCell",
										kCellKeypaths					: @{
												@"topLabel.text" : @"Your Plane",
												@"detailLabel.text" : @"Cessna Citation Encore+",
												//																@"imgaeView" : @"",
												}
										},
									@{
										kCellIdentifierKey	: @"InfoCell",
										kCellKeypaths					: @{
												@"topLabel.text" : @"Ground Transportation",
												@"detailLabel.text" : @"Requested",
												//																@"imgaeView" : @"",
												}
										},
									@{
										kCellIdentifierKey	: @"InfoCell",
										kCellKeypaths					: @{
												@"topLabel.text" : @"Your Crew",
												@"detailLabel.text" : @"Captain Brad Hanshaw",
												//																@"imgaeView" : @"",
												}
										},
									@{
										kCellIdentifierKey	: @"InfoCell",
										kCellKeypaths					: @{
												@"topLabel.text" : @"Passenger Manifest",
												@"detailLabel.text" : @"2 Passengers",
												//																@"imgaeView" : @"",
												}
										},
									@{
										kCellIdentifierKey	: @"InfoCell",
										kCellKeypaths					: @{
												@"topLabel.text" : @"Catering",
												@"detailLabel.text" : @"Requested",
												//																@"imgaeView" : @"",
												}
										},
									@{
										kCellIdentifierKey	: @"InfoCell",
										kCellKeypaths					: @{
												@"topLabel.text" : @"Advisory Notes",
												@"detailLabel.text" : @"Please Read",
												//																@"imgaeView" : @"",
												}
										},
									],
							},
					 ];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.navigationController.navigationBar setBarTintColor:DARK_BACKGROUND_COLOR];
	self.title = @"FLIGHT DETAILS";
	self.tableView.estimatedRowHeight = 44.0;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	[self.tableView registerNib:[UINib nibWithNibName:@"ReservationHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:headerIdentifier];
	
	FlightDetailTopHeaderView* tableHeaderView = (FlightDetailTopHeaderView*)self.tableView.tableHeaderView;
	//	tableHeaderView.topLabelView.text = dateString;
	//	tableHeaderView.bodyLabelView.text = @"Hello Ms. Smith";
	[tableHeaderView layoutIfNeeded];
	
	self.sections = [self createSections];
}

#pragma mark - UITableView Delegate Methods

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	ReservationHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
	NSString * title = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
	headerView.titleLabel.text = title;
	return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
	return 60.0;
}

#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.sections[section][kSectionCellsKey] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSDictionary* cellData = self.sections[indexPath.section][kSectionCellsKey][indexPath.row];
	
	NSString* identifier = cellData[kCellIdentifierKey];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
																													forIndexPath:indexPath];
//	if (!cell.backgroundView) {
//		cell.backgroundView = [[NJCellBackgroundView alloc] initWithFrame:CGRectZero];
//	}

	NSDictionary* keypaths = cellData[kCellKeypaths];
	
	[keypaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[cell setValue:obj forKeyPath:key];
	}];
 return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *title = self.sections[section][kSectionsTitleKey];
	return title;
}

@end
