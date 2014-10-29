//
//  NJOPBriefTopCollectionViewCell.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPBriefTopCollectionViewCell.h"

@implementation NJOPBriefTopCollectionViewCell

-(void)layoutSubviews {
	[super layoutSubviews];
	[self.subviews enumerateObjectsUsingBlock:^(UIView* subview, NSUInteger idx, BOOL *stop) {
		subview.layer.borderWidth = 1.0;
		subview.layer.borderColor = [UIColor greenColor].CGColor;
	}];
}
//-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//
//}
//-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//
//	CGRect frame = layoutAttributes.frame;
//	CGFloat columnWidth = [(UICollectionView*)self.superview contentSize].width;
//	CGSize fittingSize = CGSizeMake(columnWidth, UILayoutFittingExpandedSize.height);
//	frame.size = fittingSize;
//	layoutAttributes.frame = frame;
//	return layoutAttributes;
//
////	UICollectionViewLayoutAttributes * atts = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
////	return atts;
//}

@end
