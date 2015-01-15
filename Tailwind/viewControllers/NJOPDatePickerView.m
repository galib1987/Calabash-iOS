//
//  NJOPDatePickerView.m
//  Tailwind
//
//  Created by Stephen.Cohrs on 1/14/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPDatePickerView.h"
#import "NJOPDatePickerCollectionView.h"
#import "NJOPDatePickerMonthHeader.h"
#import "NJOPDatePickerDayCell.h"

@implementation NJOPDatePickerView

- (Class)collectionViewClass
{
    return [NJOPDatePickerCollectionView class];
}

- (Class)monthHeaderClass
{
    return [NJOPDatePickerMonthHeader class];
}

- (Class)dayCellClass
{
    return [NJOPDatePickerDayCell class];
}

@end
