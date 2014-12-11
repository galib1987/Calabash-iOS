//
//  NJOPCollectionParalaxViewInfo.h
//  Tailwind
//
//  Created by NetJets on 11/4/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import Foundation;

@interface NJOPCollectionParalaxViewInfo : NSObject
@property (nonatomic, readonly) NSString* identifier;
@property (nonatomic, readonly) NSString* kind;
@property (nonatomic, readonly) UINib* nib;
@property (nonatomic) CGSize referenceSize;
@property (nonatomic) CGSize minimumReferenceSize;
@property (nonatomic) BOOL alwaysOnTop;

+(instancetype)collectionViewInfoWithNib:(UINib*)nib kind:(NSString*)kind identifier:(NSString*)identifier;

@end
