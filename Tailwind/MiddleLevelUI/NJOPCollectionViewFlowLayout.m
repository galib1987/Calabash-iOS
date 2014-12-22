//
//  NJOPCollectionViewFlowLayout.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPCollectionViewFlowLayout.h"
@interface NJOPCollectionViewFlowLayout ()
@property (nonatomic) BOOL invalidatedBecauseOfBoundsChange;
@end

NSString *const NJOPCollectionPinnedParalaxHeaderIdentifier = @"NJOPCollectionPinnedParalaxHeaderIdentifier";

@implementation NJOPCollectionViewFlowLayout

+(Class)layoutAttributesClass {
	return [NJOPCollectionViewFlowLayoutAttributes class];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind
																																		 atIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
	if (!attributes && [kind isEqualToString:NJOPCollectionPinnedParalaxHeaderIdentifier]) {
		attributes = [NJOPCollectionViewFlowLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind
																																											withIndexPath:indexPath];
	}
	return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
	// The rect should compensate the header size
	CGRect adjustedRect = rect;
	adjustedRect.origin.y -= self.parallaxHeaderReferenceSize.height;

	NSMutableArray *allItems = [[super layoutAttributesForElementsInRect:adjustedRect] mutableCopy];

	NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *lastCells = [[NSMutableDictionary alloc] init];
	__block BOOL visibleParallexHeader;

	[allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		UICollectionViewLayoutAttributes *attributes = obj;

		CGRect frame = attributes.frame;
		frame.origin.y += self.parallaxHeaderReferenceSize.height;
		attributes.frame = frame;

		NSIndexPath *indexPath = [(UICollectionViewLayoutAttributes *)obj indexPath];
		if ([[obj representedElementKind] isEqualToString:UICollectionElementKindSectionHeader]) {
			[headers setObject:obj forKey:@(indexPath.section)];
		} else if ([[obj representedElementKind] isEqualToString:UICollectionElementKindSectionFooter]) {
			// Not implemeneted
		} else {
			NSIndexPath *indexPath = [(UICollectionViewLayoutAttributes *)obj indexPath];

			UICollectionViewLayoutAttributes *currentAttribute = [lastCells objectForKey:@(indexPath.section)];

			// Get the bottom most cell of that section
			if ( ! currentAttribute || indexPath.row > currentAttribute.indexPath.row) {
				[lastCells setObject:obj forKey:@(indexPath.section)];
			}

			if ([indexPath item] == 0 && [indexPath section] == 0) {
				visibleParallexHeader = YES;
			}
		}

		// For iOS 7.0, the cell zIndex should be above pinned section header
		attributes.zIndex = 1;
	}];

	// when the visible rect is at top of the screen, make sure we see
	// the parallex header
	if (CGRectGetMinY(rect) <= 0) {
		visibleParallexHeader = YES;
	}


	// Create the attributes for the Parallex header
	if (visibleParallexHeader && ! CGSizeEqualToSize(CGSizeZero, self.parallaxHeaderReferenceSize)) {
		NJOPCollectionViewFlowLayoutAttributes *currentAttribute = [NJOPCollectionViewFlowLayoutAttributes layoutAttributesForSupplementaryViewOfKind:NJOPCollectionPinnedParalaxHeaderIdentifier withIndexPath:[NSIndexPath indexPathWithIndex:0]];
		CGRect frame = currentAttribute.frame;
		frame.size.width = self.parallaxHeaderReferenceSize.width;
		frame.size.height = self.parallaxHeaderReferenceSize.height;

		CGRect bounds = self.collectionView.bounds;
		CGFloat maxY = CGRectGetMaxY(frame);

		// make sure the frame won't be negative values
		CGFloat y = MIN(maxY - self.parallaxHeaderMinimumReferenceSize.height, bounds.origin.y + self.collectionView.contentInset.top);
		CGFloat height = MAX(0, -y + maxY);


		CGFloat maxHeight = self.parallaxHeaderReferenceSize.height;
		CGFloat minHeight = self.parallaxHeaderMinimumReferenceSize.height;
		CGFloat progressiveness = (height - minHeight)/(maxHeight - minHeight);
		currentAttribute.progressiveness = progressiveness;

		// if zIndex < 0 would prevents tap from recognized right under navigation bar
		currentAttribute.zIndex = 0;

		// When parallaxHeaderAlwaysOnTop is enabled, we will check when we should update the y position
		if (self.parallaxHeaderAlwaysOnTop && height <= self.parallaxHeaderMinimumReferenceSize.height) {
			CGFloat insetTop = self.collectionView.contentInset.top;
			// Always pin to top but under the nav bar
			y = self.collectionView.contentOffset.y + insetTop;
			currentAttribute.zIndex = 2000;
		}

		currentAttribute.frame = (CGRect){
			frame.origin.x,
			y,
			frame.size.width,
			height,
		};


		[allItems addObject:currentAttribute];
	}

	if (!self.disablePinnedHeaders) {
		[lastCells enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
			NSIndexPath *indexPath = [obj indexPath];
			NSNumber *indexPathKey = @(indexPath.section);

			UICollectionViewLayoutAttributes *header = headers[indexPathKey];
			// CollectionView automatically removes headers not in bounds
			if ( ! header) {
				header = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
																											atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section]];

				if (header) {
					[allItems addObject:header];
				}
			}
			[self updateHeaderAttributes:header lastCellAttributes:lastCells[indexPathKey]];
		}];
	}

	return allItems;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
	CGRect frame = attributes.frame;
	frame.origin.y += self.parallaxHeaderReferenceSize.height;
	attributes.frame = frame;
	return attributes;
}

- (CGSize)collectionViewContentSize {
	CGSize size = [super collectionViewContentSize];
	size.height += self.parallaxHeaderReferenceSize.height;
	return size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
	return YES;
}

#pragma mark Helper

- (void)updateHeaderAttributes:(UICollectionViewLayoutAttributes *)attributes lastCellAttributes:(UICollectionViewLayoutAttributes *)lastCellAttributes
{
	CGRect currentBounds = self.collectionView.bounds;
	attributes.zIndex = 1024;
	attributes.hidden = NO;

	CGPoint origin = attributes.frame.origin;

	CGFloat sectionMaxY = CGRectGetMaxY(lastCellAttributes.frame) - attributes.frame.size.height;
	CGFloat y = CGRectGetMaxY(currentBounds) - currentBounds.size.height + self.collectionView.contentInset.top;

	if (self.parallaxHeaderAlwaysOnTop) {
		y += self.parallaxHeaderMinimumReferenceSize.height;
	}

	CGFloat maxY = MIN(MAX(y, attributes.frame.origin.y), sectionMaxY);

	//    NSLog(@"%.2f, %.2f, %.2f", y, maxY, sectionMaxY);

	origin.y = maxY;

	attributes.frame = (CGRect){
		origin,
		attributes.frame.size
	};
}

@end

@implementation NJOPCollectionViewFlowLayoutAttributes


@end