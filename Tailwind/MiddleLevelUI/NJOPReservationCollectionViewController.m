//
//  NJOReservationCollectionViewController.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPReservationCollectionViewController.h"
#import "NJOPCollectionViewFlowLayout.h"
#import "NJOPClient.h"
#import "NJOPReservation.h"


static NSString * topHeaderIdentifier 		= @"NJOPNavigationTitleView";
static NSString * cellIdentifier 					= @"NJOPBriefTopCollectionViewCell";
static NSString * sectionHeaderIdentifier = @"NJOPAllFlightsHeader";

@interface NJOPReservationCollectionViewController ()
@property (nonatomic, strong) NSDictionary*identifiers;
@property (nonatomic) CGFloat width;
@property (nonatomic, strong) UINib *headerNib;
@end

@implementation NJOPReservationCollectionViewController

#pragma mark - UIViewController 

-(UINib *)headerNib {
	if (!_headerNib) {
		_headerNib = [UINib nibWithNibName:topHeaderIdentifier bundle:nil];
#if DEBUG
		NSAssert1([[_headerNib instantiateWithOwner:nil options:nil] objectAtIndex:0], @"missing or incorrect file:", topHeaderIdentifier);
#endif
	}
	return _headerNib;
}

-(void)viewDidLoad {
	[super viewDidLoad];

	NJOPCollectionViewFlowLayout *layout = (id)self.collectionViewLayout;

	if ([layout isKindOfClass:[NJOPCollectionViewFlowLayout class]]) {
		layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 64);
		layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 44);
		layout.itemSize = CGSizeMake(self.view.frame.size.width, layout.itemSize.height);
		layout.parallaxHeaderAlwaysOnTop = YES;

		// If we want to disable the sticky header effect
		layout.disablePinnedHeaders = NO;
		layout.footerReferenceSize = CGSizeZero;
	}
}

#pragma mark -

-(void)registerReusableViews {

	UINib* nib = [UINib nibWithNibName:cellIdentifier bundle:nil];

	UICollectionViewCell* cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
	NSAssert1(cell, @"missing or incorrect file:", cellIdentifier);

	[self.collectionView registerNib:nib
				forCellWithReuseIdentifier:cellIdentifier];

	_identifiers = @{cellIdentifier : cell};

	nib = [UINib nibWithNibName:sectionHeaderIdentifier bundle:nil];
#if DEBUG
	UICollectionReusableView* view = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
	NSAssert1(view, @"missing or incorrect file:", sectionHeaderIdentifier);
#endif
	[self.collectionView registerNib:nib
				forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
							 withReuseIdentifier:sectionHeaderIdentifier];

	[self.collectionView registerNib:self.headerNib
				forSupplementaryViewOfKind:NJOPCollectionPinnedParalaxHeaderIdentifier
							 withReuseIdentifier:topHeaderIdentifier];
}


-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	__weak NJOPReservationCollectionViewController* wself = self;
	[coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		[wself.collectionView.collectionViewLayout invalidateLayout];
	} completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
	}];
}

-(void)loadDataSource {

	__weak NJOPReservationCollectionViewController* wself = self;

	[NJOPClient GETReservationWithInfo:nil completion:^(NJOPReservation *reservation, NSError *error) {
		[wself updateWithReservation:reservation];
	}];
}

-(void)updateWithReservation:(NJOPReservation*)reservation {

	//UIImage* image = [UIImage imageNamed:@"sun"];
	NSDictionary* fboDictionary = @{
																	@"NJOPAllFlightsHeader" 	: @{
																			@"titleLabel.text" : [NSString stringWithFormat:@"Reservation: %@", reservation.reservationId]
																			},
																	@"NJOPBriefTopCollectionViewCell" : @{
																			//@"topRightView.tailImageView.text"					: @"",
																			@"topLeftView.locationLabel.text"         	: reservation.departureFboName,
																			@"topLeftView.numberLabel.text"         		: reservation.departureAirportId,
																			@"topLeftView.timeLabel.text"         			: reservation.departureTime,
																			//@"topLeftView.directionLabel.text"					: @"",
																			@"topLeftView.airportNameLabel.text"				: reservation.departureAirportCity,
																			@"topLeftView.airportAddressLabel.text"		: @"Address:Not Availbel",
																			@"topLeftView.phoneNumberLabel.text"				: @"",

																			//@"topRightView.tailImageView.text"					: @"",
																			@"topRightView.locationLabel.text"         : reservation.arrivalFboName,
																			@"topRightView.numberLabel.text"         	: reservation.arrivalAirportId,
																			@"topRightView.timeLabel.text"         		: reservation.arrivalTime,
																			//@"topRightView.directionLabel.text"				: @"",
																			@"topRightView.airportNameLabel.text"			: reservation.arrivalAirportCity,
																			@"topRightView.airportAddressLabel.text"		: @"Address:Not Availbel",
																			@"topRightView.phoneNumberLabel.text"			: @"",
																			
																			@"topMiddleView.tailNumberLabel.text"			: reservation.tailNumber,
																			@"topMiddleView.estimatedTravelTimeLabel.text" : [@"Est. Travel:" stringByAppendingFormat:@"%@ %@", reservation.travelTime, reservation.stopsText],
																			}
																	};

	NSArray* sections = @[
												@{
													kSimpleDataSourceSectionsHeaderIdentifierKey : @"NJOPAllFlightsHeader",
													kSimpleDataSourceSectionsHeaderKeyapthsKey : fboDictionary[@"NJOPAllFlightsHeader"],
													kSimpleDataSourceSectionCellsKey : @[
															@{
																kSimpleDataSourceCellIdentifierKey	: @"NJOPBriefTopCollectionViewCell",
																kSimpleDataSourceCellKeypaths 			: fboDictionary[@"NJOPBriefTopCollectionViewCell"]
																}
															]
													},
												];
	self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
	self.dataSource.reusableViewsKindsToIdentifiers = @{NJOPCollectionPinnedParalaxHeaderIdentifier : topHeaderIdentifier};
	self.dataSource.title = @"FLIGHT DETAILS";
}

-(NSString*)cellIdentifierAtIndexPath:(NSIndexPath*)indexPath {
	id sectionInfo = self.dataSource.sections[indexPath.section];
	NSArray* cells = sectionInfo[kSimpleDataSourceSectionCellsKey];
	id cellInfo = cells[indexPath.item];
	return cellInfo[kSimpleDataSourceCellIdentifierKey];
}

-(CGSize)collectionViewContentSize:(UICollectionViewFlowLayout*)flowLayout { //Workaround
	CGSize superSize = [flowLayout.collectionView contentSize];
	CGRect frame = self.collectionView.frame;
	return CGSizeMake(fmaxf(superSize.width, CGRectGetWidth(frame)), fmaxf(superSize.height, CGRectGetHeight(frame)));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* identifier = [self cellIdentifierAtIndexPath:indexPath];
	UICollectionViewCell* cell = _identifiers[identifier];
	if (cell && [collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
		UICollectionViewFlowLayout* flowLayout = (UICollectionViewFlowLayout*)collectionViewLayout;
		CGFloat widthInsets = (flowLayout.sectionInset.left + flowLayout.sectionInset.right);;
		CGFloat columnWidth = [self collectionViewContentSize:flowLayout].width - widthInsets;

		CGSize fittingSize = CGSizeMake(columnWidth, UILayoutFittingExpandedSize.height);
		CGSize size = [cell systemLayoutSizeFittingSize:fittingSize];
		NSLog(@"%d:%@, %@",indexPath.item, NSStringFromCGSize(size), NSStringFromCGSize(self.collectionView.contentSize));
		return size;
	}
	return [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

	if ([kind isEqualToString:NJOPCollectionPinnedParalaxHeaderIdentifier]) {
		UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:topHeaderIdentifier forIndexPath:indexPath];

		return cell;
	}
	return [super collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}


@end
