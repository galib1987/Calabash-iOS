//
//  NJOPNavigationTitleView.h
//  Tailwind
//
//  Created by Amos Elmaliah on 10/20/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface NJOPNavigationTitleView : UIView
@property (strong, nonatomic) IBOutlet UILabel *leftTItle;
@property (strong, nonatomic) IBOutlet UILabel *rightTitle;
@property (nonatomic,copy) CGSize (^fittedSizeForSize) (CGSize requiredSize,CGSize superFittedSize);
@end
