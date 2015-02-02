//
//  NJOPNavigationController.h
//  Tailwind
//
//  Created by netjets on 2/2/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NJOPNavigationControllerDelegate <NSObject>
- (void) pushScreen:(NSDictionary *) screenData;
@end

@interface NJOPNavigationController : UINavigationController

@property (nonatomic,copy) dispatch_block_t completionBlock; // get completion for things
@property (nonatomic, assign) id delegate;

@end
