//
//  NJOPActionsViewController.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPActionsViewController.h"

@interface NJOPActionsViewController ()
@property (nonatomic, strong) NSDictionary*identifiers;
@end

static NSString* identifier = @"NJOPInfoCell";

@implementation NJOPActionsViewController

-(NSInteger)columns {
	if (_columns == 0) {
		_columns = 3;
	}
	return _columns;
}


-(void)registerReusableViews {
	UINib* nib = [UINib nibWithNibName:identifier bundle:nil];
	[self.collectionView registerNib:nib
				forCellWithReuseIdentifier:identifier];

	UICollectionViewCell* cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
	_identifiers = @{identifier : cell};
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	__weak NJOPActionsViewController* wself = self;
	[coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		[wself.collectionView.collectionViewLayout invalidateLayout];
	} completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
	}];
}

-(void)loadDataSource {
	NSArray* sections = @[@{
													kSimpleDataSourceSectionsTitleKey : @"Reservation: 123214 (2 Legs)",
													kSimpleDataSourceSectionCellsKey : @[

															@{
																kSimpleDataSourceCellIdentifierKey	: identifier,
																kSimpleDataSourceCellKeypaths				: @{
																		@"topLabel.text" : @"Your Plane",
																		@"detailLabel.text" : @"Cessna Citation Encore+",
																		//																@"imgaeView" : @"",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: identifier,
																kSimpleDataSourceCellKeypaths				: @{
																		@"topLabel.text" : @"Ground Transportation",
																		@"detailLabel.text" : @"Requested",
																		//																@"imgaeView" : @"",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: identifier,
																kSimpleDataSourceCellKeypaths				: @{
																		@"topLabel.text" : @"Your Crew",
																		@"detailLabel.text" : @"Captain Brad Hanshaw",
																		//																@"imgaeView" : @"",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: identifier,
																kSimpleDataSourceCellKeypaths				: @{
																		@"topLabel.text" : @"Passenger Manifest",
																		@"detailLabel.text" : @"2 Passengers",
																		//																@"imgaeView" : @"",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: identifier,
																kSimpleDataSourceCellKeypaths				: @{
																		@"topLabel.text" : @"Catering",
																		@"detailLabel.text" : @"Requested",
																		//																@"imgaeView" : @"",
																		}
																},
															@{
																kSimpleDataSourceCellIdentifierKey	: identifier,
																kSimpleDataSourceCellKeypaths				: @{
																		@"topLabel.text" : @"Advisory Notes",
																		@"detailLabel.text" : @"Please Read",
																		//																@"imgaeView" : @"",
																		}
																},
															]
													}];
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
		CGSize contentSize = [self collectionViewContentSize:flowLayout];

		CGFloat sectionWidth = contentSize.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right);
		CGFloat columnWidth = (sectionWidth / self.columns) - flowLayout.minimumInteritemSpacing ;
//	this is a fix for: [cell systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
		CGSize size = [cell aapl_preferredLayoutSizeFittingSize:UILayoutFittingExpandedSize];
		size.width = columnWidth;
		return size;
	}
	return [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
}

@end
