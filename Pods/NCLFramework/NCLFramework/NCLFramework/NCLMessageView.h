//
//  NCLErrorView.h
//  Waypoint
//
//  Created by Chad Long on 3/14/13.
//  Copyright (c) 2013 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class NCLMessagePresenter;

@interface NCLMessageView : UIView

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) NSString *messageText;
@property (nonatomic) BOOL shouldAutoDismiss;

@property (nonatomic, strong) NCLMessagePresenter *delegate;

@end
