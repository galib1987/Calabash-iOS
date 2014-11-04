//
//  NJOPCollectionParalaxViewInfo.m
//  Tailwind
//
//  Created by Amos Elmaliah on 11/4/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPCollectionParalaxViewInfo.h"

@implementation NJOPCollectionParalaxViewInfo

-(instancetype)initWithNib:(UINib *)nib kind:(NSString *)kind identifier:(NSString *)identifier {
	self = [super init];
	if (self) {
#if DEBUG
		NSAssert([nib instantiateWithOwner:nil options:nil][0], @"missing or invalid file nib");
#endif
		_kind = [kind copy];
		_nib = nib;
		_identifier = [identifier copy];
	}
	return self;
}

+(instancetype)collectionViewInfoWithNib:(UINib *)nib kind:(NSString *)kind identifier:(NSString *)identifier {
	return [[self alloc] initWithNib:nib kind:kind identifier:identifier];
}

@end
