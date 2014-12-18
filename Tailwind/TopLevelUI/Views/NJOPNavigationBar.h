//
//  NJOPNavigationBar.h
//  Tailwind
//
//  Created by NetJets on 11/5/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;
#import "UIColor+NJOP.h"

IB_DESIGNABLE

@interface NJOPNavigationBar : UINavigationBar
@property(nonatomic,retain) IBInspectable UIColor *tintColor;
@property(nonatomic,retain) IBInspectable UIColor *barTintColor;
@property(nonatomic,copy) CGSize(^sizeThatFitsBlock)(CGSize size,CGSize fittedSize);
@end
