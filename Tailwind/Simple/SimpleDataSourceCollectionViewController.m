//
//  SimpleDataSourceCollectionViewController.m
//  TailWind
//
//  Created by Amos Elmaliah on 10/15/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
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

	[self loadDataSource];
	[self registerReusableViews];

	if (!self.collectionView.dataSource || self.collectionView.dataSource == self) {
		self.dataSource.controller = self;
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
		return [self.dataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
	}
	return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	NSString* segue = nil;
	if ([self.dataSource respondsToSelector:@selector(segueForIndexPath:)] &&
			(segue = [self.dataSource segueForIndexPath:indexPath])) {
		[self performSegueWithIdentifier:segue sender:self];
		return;
	} else  if (self.dataSource.didSelectBlock) {
		self.dataSource.didSelectBlock(self, indexPath);
	}
}

#pragma mark <UICollectionViewDelegate>

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
