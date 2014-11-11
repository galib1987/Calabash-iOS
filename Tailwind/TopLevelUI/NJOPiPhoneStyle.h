//
//  NJOPiPhoneStyle.h
//  Tailwind
//
//  Created by Amos Elmaliah on 11/11/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import UIKit;

#import "UIViewController+NJNavigationBarHiding.h"

@protocol NJOPiPhoneStyle
-(void)njop_configureController;
@end

@interface NJOPiPhoneStyle : NSObject <UINavigationControllerDelegate>
@end
