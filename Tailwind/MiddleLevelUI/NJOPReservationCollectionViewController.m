//
//  NJOReservationCollectionViewController.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPReservationCollectionViewController.h"


@interface NJOPReservationCollectionViewController ()
@property (nonatomic, strong) NSDictionary*identifiers;
@property (nonatomic) CGFloat width;
@end

static NSString* identifier = @"NJOPBriefTopCollectionViewCell";
static NSString* headerIdentifier = @"NJOPAllFlightsHeader";
@implementation NJOPReservationCollectionViewController

#pragma mark - UIViewController 

-(void)viewDidLoad {
	[super viewDidLoad];
	UICollectionViewFlowLayout* flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
	if ([flowLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
//		flowLayout.headerReferenceSize = CGSizeZero;
		flowLayout.footerReferenceSize = CGSizeZero;
	}
}
#pragma mark -

-(void)registerReusableViews {

	UINib* nib = [UINib nibWithNibName:identifier bundle:nil];
	UICollectionViewCell* cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
	NSAssert1(cell, @"missing or incorrect file:", identifier);

	[self.collectionView registerNib:nib
				forCellWithReuseIdentifier:identifier];

	_identifiers = @{identifier : cell};

	NSString* headerIdentifier = @"NJOPAllFlightsHeader";
	nib = [UINib nibWithNibName:headerIdentifier bundle:nil];
	UICollectionReusableView* view = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
	NSAssert1(view, @"missing or incorrect file:", headerIdentifier);
	[self.collectionView registerNib:nib
				forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
							 withReuseIdentifier:headerIdentifier];

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
	NSArray* sections = @[
												@{
													kSimpleDataSourceSectionsHeaderIdentifierKey : headerIdentifier,
													kSimpleDataSourceSectionsHeaderKeyapthsKey : @{
															@"titleLabel.text" : @"Reservation"
															},
													kSimpleDataSourceSectionCellsKey : @[
															@{
																kSimpleDataSourceCellIdentifierKey	: identifier,
																kSimpleDataSourceCellKeypaths 			: @{
																		}
																}
															]
													},
												@{
													kSimpleDataSourceSectionsHeaderIdentifierKey : headerIdentifier,
													kSimpleDataSourceSectionsHeaderKeyapthsKey : @{
															@"titleLabel.text" : @"Reservation"
															},
													kSimpleDataSourceSectionCellsKey : @[
															@{
																kSimpleDataSourceCellIdentifierKey	: identifier,
																kSimpleDataSourceCellKeypaths 			: @{
																		}
																}
															]
													}
												];
	self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
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


@end
