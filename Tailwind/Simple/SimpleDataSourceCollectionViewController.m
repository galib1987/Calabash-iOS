//
//  SimpleDataSourceCollectionViewController.m
//  TailWind
//
//  Created by NetJets on 10/15/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "SimpleDataSourceCollectionViewController.h"

@interface SimpleDataSourceCollectionViewController ()

@end

@implementation SimpleDataSourceCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(void)loadDataSource {

}

-(void)registerReusableViews {
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.collectionView setBackgroundColor:SCROLLVIEW_BACKGORUND_COLOR];
	self.title = self.dataSource.title ? : self.title;
	[self loadDataSource];
	[self registerReusableViews];

	if (!self.collectionView.dataSource || self.collectionView.dataSource == self) {
		self.collectionView.dataSource = self.dataSource;
	}
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource numberOfSectionsInCollectionView:collectionView];
	}
	return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource collectionView:collectionView numberOfItemsInSection:section];
	}
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.dataSource respondsToSelector:_cmd]) {
		UICollectionViewCell*cell = [self.dataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
		[cell aapl_Xcode6OniOS7hotfix];
	}
	return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	NSString* segue = nil;
	if ([self.dataSource respondsToSelector:@selector(segueForCellAtIndexPath:)] &&
			(segue = [self.dataSource segueForCellAtIndexPath:indexPath])) {
		[self performSegueWithIdentifier:segue sender:self];
		return;
	} else  if (self.dataSource.didSelectBlock) {
		self.dataSource.didSelectBlock(self, indexPath);
	}
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	if ([self.dataSource respondsToSelector:_cmd]) {
		return [self.dataSource collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
	}
	return nil;
}


#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
