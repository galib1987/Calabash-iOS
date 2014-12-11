//
//  NJOPHorizontalHairlineView.h
//  Tailwind
//
//  Created by NetJets on 11/6/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

@interface NJOPHorizontalHairlineView : UIView

/// A convenience for accessing the thickness of the hairline view. This will always be the inverse of the scale of the main display. For example, on an iPhone 5S, this will be 0.5. On a first generation iPad mini, this would be 1.0.
@property (nonatomic, readonly) CGFloat thickness;

@end
