//
//  ReservationDetailViewController.m
//  Tailwind
//
//  Created by NetJets on 9/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "ReservationDetailViewController.h"
#import "WeatherTableCell.h"
#import "FBOTableCell.h"
#import "TailCell.h"
#import "FlightDetailTopHeaderView.h"
#import "NJCellBackgroundView.h"
#import "ReservationHeaderView.h"

#import "NJOPClient.h"
#import "NJOPReservation.h"

@interface ReservationDetailViewController ()
@end

@implementation ReservationDetailViewController

- (IBAction)shareAction:(id)sender {

	UIActivityViewController* activityController = [[UIActivityViewController alloc] initWithActivityItems:@[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypeAirDrop] applicationActivities:@[]];


	if ([activityController respondsToSelector:@selector(setCompletionWithItemsHandler:)]) {
		[activityController setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {

		}];

	}
#if  __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
	else if([activityController respondsToSelector:@selector(setCompletionHandler:)]) {

	 [activityController setCompletionHandler:^(NSString *activityType, BOOL completed) {

		}];
 }
#endif

	[self presentViewController:activityController animated:YES completion:^{

	}];
}

static NSString* headerIdentifier = @"ReservationHeaderView";

-(void)updateWithReservation:(NJOPReservation*)reservation {

	//UIImage* image = [UIImage imageNamed:@"sun"];
	NSDictionary* fboDictionary = @{
																	headerIdentifier 	: @{
																			@"titleLabel.text" : [NSString stringWithFormat:@"Reservation: %@", reservation.reservationId]
																			},
																	@"FBOTableCell" : @{
																			@"fromFBODateLabel.text"			: reservation.departureDateString,
																			@"toFBODateLabel.text"				: reservation.arrivalDateString,
																			@"departureLabel.text" 				: [NSString stringWithFormat:@"Departing %@", reservation.departureTime],
																			@"arrivalLabel.text" 					: [NSString stringWithFormat:@"Arriving %@", reservation.arrivalTime],

																			@"fromFBOAirpotCodeLabel.text"	: reservation.departureAirportId,
																			@"toFBOAirpotCodeLabel.text"		: reservation.arrivalAirportId,

																			@"fromFBOTailNumberLabel.text"	: reservation.tailNumber,
																			@"travelTimeLabel.text" 			: [@"Est. Travel:" stringByAppendingFormat:@"%@ %@", reservation.travelTime, reservation.stopsText],

																			@"fromFBOLocationLabel.text"		: reservation.departureFboName,
																			@"toFBOLocationLabel.text"			: reservation.arrivalFboName
																			}
																	};
	NSArray* sections = @[
												@{
													kSimpleDataSourceSectionsHeaderIdentifierKey : headerIdentifier,
													kSimpleDataSourceSectionsHeaderKeyapthsKey 	: fboDictionary[headerIdentifier],
													kSimpleDataSourceSectionCellsKey : @[
															@{
																kSimpleDataSourceCellIdentifierKey			: @"FBOTableCell",
																kSimpleDataSourceCellKeypaths			 			: fboDictionary[@"FBOTableCell"]
																},
															@{
																kSimpleDataSourceCellIdentifierKey		: @"WeatherTableCell",
																kSimpleDataSourceCellKeypaths					: @{
																		@"firstDateLabel.text" : @"Mon, Oct 27, 2014",
																		@"firstLocationLabel.text" : @"Teterboro, NJ",
																		@"firstTimeLabel.text" : @"12:00PM EST",
																		@"firstTemperatureLabel.text" : @"60º",
																		//@"firstImageView.image" : nil;
																		@"secondDateLabel.text" : @"Mon, Oct 27, 2014",
																		@"secondLocationLabel.text" : @"Naples, FL",
																		@"secondTimeLabel.text" : @"2:45PM EST",
																		@"secondTemperatureLabel.text" : @"83º",
																		//@"secondImageView.image" : nil;
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

-(void)loadDataSource {

	__weak ReservationDetailViewController* wself = self;

	[NJOPClient GETReservationWithInfo:nil completion:^(NJOPReservation *reservation, NSError *error) {
		[wself updateWithReservation:reservation];
	}];
}

@end
