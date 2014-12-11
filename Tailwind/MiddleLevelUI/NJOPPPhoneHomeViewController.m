//
//  NJOPPPhoneHomeViewController.m
//  Tailwind
//
//  Created by NetJets on 11/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPPPhoneHomeViewController.h"

#import "NJOPClient.h"
#import "NJOPReservation.h"
#import "NJOPSummaryViewTopHeaderView.h"
#import "NJOPSummaryNavigationTitleView.h"
#import "NJOPNavigationBar.h"

static NSString* headerIdentifier = @"ReservationHeaderView";

@implementation NJOPPPhoneHomeViewController

-(void)addStuff:stuff {

}
-(void)searchStuff:stuff {

}

-(void)updateWithReservations:(NSArray*)reservations {

	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd MMM, YYYY"];
	NSString* dateString = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@"\n Welcome My Smith"];


	NJOPReservation* todaysReservations = reservations[0];

	NSDictionary* todaysFBO = @{
															@"FBOTableCell" : @{
																	@"fromFBODateLabel.text"			: todaysReservations.departureDateString,
																	@"toFBOTimeLabel.text" 				: todaysReservations.departureTime,
																	@"fromFBOTimeLabel.text" 					: todaysReservations.arrivalTime,

																	@"fromFBOAirpotCodeLabel.text"	: [NSString stringWithFormat:@"%@, %@", todaysReservations.departureAirportId, todaysReservations.departureAirportCity],
																	@"toFBOAirpotCodeLabel.text"		: [NSString stringWithFormat:@"%@, %@", todaysReservations.arrivalAirportId, todaysReservations.arrivalAirportCity],

//																	@"fromFBOTailNumberLabel.text"	: todaysReservations.tailNumber,
																	@"travelTimeLabel.text" 			: [NSString stringWithFormat:@"%@ %@", todaysReservations.travelTime, todaysReservations.stopsText],

//																	@"fromFBOLocationLabel.text"		: todaysReservations.departureFboName,
//																	@"toFBOLocationLabel.text"			: todaysReservations.arrivalFboName
																	}
															};

	NSArray*sections = @[
												@{
													kSimpleDataSourceSectionCellsKey : @[
															@{
																kSimpleDataSourceCellIdentifierKey			: @"FBOTableCell",
																kSimpleDataSourceCellKeypaths			 			: todaysFBO[@"FBOTableCell"]
																},
															@{
																kSimpleDataSourceCellIdentifierKey			: @"NJOPUpcomingFlightTableCell"
																},
															@{
																kSimpleDataSourceCellIdentifierKey			: @"NJOPCurrentFBOTableCell"
																},
															@{
																kSimpleDataSourceCellIdentifierKey			: @"NJOPNOFBOTableCell"
																}
															],
													},
												];

	self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
	self.dataSource.headerFooterCellIdentifiers = @[@"SummaryHeaderView"];
	[self.dataSource setConfigureHeaderFooterViewBlock:^(UIView *headerView) {
		if ([headerView isKindOfClass:[NJOPSummaryViewTopHeaderView class]]) {
			NJOPSummaryViewTopHeaderView* tableHeaderView = (NJOPSummaryViewTopHeaderView*)headerView;
			tableHeaderView.topLabelView.text = dateString;
			tableHeaderView.bodyLabelView.text = @"Hello Ms. Smith";
			[tableHeaderView layoutIfNeeded];
		}
	}];

}

-(void)loadDataSource {

	__weak NJOPPPhoneHomeViewController* wself = self;

	[NJOPClient GETReservationWithInfo:nil completion:^(NJOPReservation *reservation, NSError *error) {
		[wself updateWithReservations:@[reservation]];
	}];
}

-(void)viewDidLoad {
	[super viewDidLoad];

	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd MMM, YYYY"];
	NSString* dateString = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@"\n Welcome My Smith"];

	UINib* nib = [UINib nibWithNibName:NSStringFromClass([NJOPSummaryNavigationTitleView class])
															bundle:nil];
	NJOPSummaryNavigationTitleView*titleView = [nib instantiateWithOwner:nil
																															 options:nil][0];

	self.navigationItem.titleView = titleView;
	[(NJOPNavigationBar*)self.navigationController.navigationBar setSizeThatFitsBlock:^CGSize(CGSize size, CGSize fittedSize) {
		CGFloat height = [titleView systemLayoutSizeFittingSize:fittedSize].height;
		return CGSizeMake(fittedSize.width, height + 20);
	}];

	[self.dataSource setConfigureHeaderFooterViewBlock:^(UIView *headerView) {
		if ([headerView isKindOfClass:[NJOPSummaryViewTopHeaderView class]]) {
			NJOPSummaryViewTopHeaderView* tableHeaderView = (NJOPSummaryViewTopHeaderView*)headerView;
			tableHeaderView.topLabelView.text = dateString;
			tableHeaderView.bodyLabelView.text = @"Hello Ms. Smith";
			[tableHeaderView layoutIfNeeded];
		}
	}];

}

- (void) checkSession {
    
}

@end
