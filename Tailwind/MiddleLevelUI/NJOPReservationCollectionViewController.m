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
#import <objc/runtime.h>

static NSString * cellIdentifier 					= @"NJOPBriefTopCollectionViewCell";
static NSString * sectionHeaderIdentifier = @"NJOPAllFlightsHeader";

@interface NJOPReservationCollectionViewController ()
@property (nonatomic, strong) NSDictionary*identifiers;
@end

#define USE_PARALAX_VIEW 0
#if USE_PARALAX_VIEW
@interface NJOPReservationCollectionViewController (ParalaxView)
@property (nonatomic, readonly) NJOPCollectionParalaxViewInfo* paralaxViewInfo;
-(void)configureForParalaxView;
@end
#endif //USE_PARALAX_VIEW

@implementation NJOPReservationCollectionViewController

#pragma mark - UIViewController 

-(void)viewDidLoad {
	[super viewDidLoad];
#if USE_PARALAX_VIEW
	[self configureForParalaxView];
#endif //USE_PARALAX_VIEW
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

#if USE_PARALAX_VIEW
	[self.collectionView registerNib:self.paralaxViewInfo.nib
				forSupplementaryViewOfKind:self.paralaxViewInfo.kind
							 withReuseIdentifier:self.paralaxViewInfo.identifier];
#endif// USE_PARALAX_VIEW
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
																			@"topTile.leftLabel.text" 									: @"Departure!!",
																			@"topTile.centerLabel.text"									: @"",
																			//@"topRightView.tailImageView.text"					: @"",
																			@"topLeftView.locationLabel.text"         	: reservation.departureFboName,
																			@"topLeftView.numberLabel.text"         		: reservation.departureAirportId,
																			@"topLeftView.timeLabel.text"         			: reservation.departureTime,
																			//@"topLeftView.directionLabel.text"					: @"",
																			@"topLeftView.airportNameLabel.text"				: reservation.departureAirportCity,
																			@"topLeftView.airportAddressLabel.text"		: @"Address:Not Available",
																			@"topLeftView.phoneNumberLabel.text"				: @"",

																			//@"topRightView.tailImageView.text"					: @"",
																			@"topRightView.locationLabel.text"         : reservation.arrivalFboName,
																			@"topRightView.numberLabel.text"         	: reservation.arrivalAirportId,
																			@"topRightView.timeLabel.text"         		: reservation.arrivalTime,
																			//@"topRightView.directionLabel.text"				: @"",
																			@"topRightView.airportNameLabel.text"			: reservation.arrivalAirportCity,
																			@"topRightView.airportAddressLabel.text"		: @"Address:Not Available",
																			@"topRightView.phoneNumberLabel.text"			: @"",
																			
																			@"topMiddleView.tailNumberLabel.text"			: reservation.tailNumber,
																			@"topMiddleView.estimatedTravelTimeLabel.text" : [@"Est. Travel:" stringByAppendingFormat:@"%@ %@", reservation.travelTime, reservation.stopsText],

																			@"bottomView.leftDateLabel.text" : @"Mon Aug 28, 2014",
																			@"bottomView.leftLocationLabel.text" : @"Teterboro, NJ",
																			@"bottomView.leftTimeLabel.text" : @"12:00PM EST",
																			@"bottomView.leftTemperatureLabel.text" : @"66º",
																			//@"bottomView.leftImageView.image" : nil,

																			@"bottomView.rightDateLabel.text" : @"Mon, Aug 28, 2014",
																			@"bottomView.rightLocationLabel.text" : @"Naples, FL",
																			@"bottomView.rightTimeLabel.text" : @"2:45PM EST",
																			@"bottomView.rightTemperatureLabel.text" : @"81º",
																			//@"bottomView.rightImageView.image" : nil
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
#if USE_PARALAX_VIEW
	self.dataSource.reusableViewsKindsToIdentifiers = @{self.paralaxViewInfo.kind : self.paralaxViewInfo.identifier};
#endif // USE_PARALAX_VIEW
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
		return size;
	}
	return [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
}
@end


@implementation NJOPReservationCollectionViewController (ParalaxView)

-(void)configureForParalaxView {
	NJOPCollectionViewFlowLayout *layout = (id)self.collectionViewLayout;
	if ([layout isKindOfClass:[NJOPCollectionViewFlowLayout class]]) {
		[self configureFlowLayoutForParalaxView:layout];
	}
}
-(NJOPCollectionParalaxViewInfo *)paralaxViewInfo {
	NJOPCollectionParalaxViewInfo *paralaxViewInfo = objc_getAssociatedObject(self, _cmd);
	if (!paralaxViewInfo) {
		static NSString * Identifier 		= @"NJOPParalaxView";
		UINib* nib = [UINib nibWithNibName:Identifier bundle:nil];
		paralaxViewInfo = [NJOPCollectionParalaxViewInfo collectionViewInfoWithNib:nib kind:NJOPCollectionPinnedParalaxHeaderIdentifier identifier:Identifier];
		paralaxViewInfo.alwaysOnTop = YES;
		CGFloat width = self.collectionView.contentSize.width;
		paralaxViewInfo.referenceSize = CGSizeMake(width, 64);
		paralaxViewInfo.minimumReferenceSize = CGSizeMake(width, 0);
		objc_setAssociatedObject(self, _cmd, paralaxViewInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return paralaxViewInfo;
}

// this for a case we want to add a paralax view:
-(void)configureFlowLayoutForParalaxView:(NJOPCollectionViewFlowLayout*)layout{

	layout.parallaxHeaderReferenceSize = self.paralaxViewInfo.referenceSize;
	layout.parallaxHeaderMinimumReferenceSize = self.paralaxViewInfo.minimumReferenceSize;
	layout.parallaxHeaderAlwaysOnTop = self.paralaxViewInfo.alwaysOnTop;

	// If we want to disable the sticky header effect
	layout.disablePinnedHeaders = NO;
	layout.footerReferenceSize = CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {


	if ([kind isEqualToString:self.paralaxViewInfo.kind]) {
		UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
																																				withReuseIdentifier:self.paralaxViewInfo.identifier
																																							 forIndexPath:indexPath];
		return cell;
	}
	return [super collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}

@end