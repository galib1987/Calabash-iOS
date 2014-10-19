//
//  NJOPCollectionViewFlowLayout.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/17/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPCollectionViewFlowLayout.h"

@implementation NJOPCollectionViewFlowLayout

+(Class)layoutAttributesClass {
	return [NJOPCollectionViewFlowLayoutAttribntes class];
}

//-(id)initWithCoder:(NSCoder *)aDecoder {
//	self = [super initWithCoder:aDecoder];
//	if (self) {
//
//	}
//	return self;
//}

//-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//	NSArray* all = [super layoutAttributesForElementsInRect:rect];
//	CGFloat minimumInteritemSpacing =  self.minimumInteritemSpacing;;
//	CGFloat minimumLineSpacing = self.minimumLineSpacing;
//	CGFloat width = (self.collectionViewContentSize.width - (minimumInteritemSpacing * 3)) /3;
//	[all enumerateObjectsUsingBlock:^(NJOPCollectionViewFlowLayoutAttribntes* attribtues, NSUInteger idx, BOOL *stop) {
//		CGRect frame = attribtues.frame;
//		frame.size.width = width;
//		attribtues.frame  = frame;
//	}];
//	return all;
//}


-(CGSize)collectionViewContentSize { //Workaround
	CGSize superContentSize = [super collectionViewContentSize];
	CGRect frame = self.collectionView.frame;
	CGSize fixedSize = CGSizeMake(fmaxf(superContentSize.width, CGRectGetWidth(frame)), fmaxf(superContentSize.height, CGRectGetHeight(frame)));
	return fixedSize;
}

@end

@implementation NJOPCollectionViewFlowLayoutAttribntes


@end