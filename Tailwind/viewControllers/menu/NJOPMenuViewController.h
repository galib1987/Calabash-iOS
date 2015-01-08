//
//  NJOPMenuViewController.h
//  Tailwind
//
//  Created by David Lin on 1/8/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPHamburgerViewController.h"



@interface NJOPMenuViewController : UIViewController <NJOPHamburgerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainButtonsView;
@property (nonatomic, assign) float screenHeight;
@property (nonatomic, assign) float screenWidth;
@property (nonatomic, assign) int buttonState;
@property (nonatomic, retain) NJOPHamburgerViewController *hambergerViewController;

@property (weak, nonatomic) IBOutlet UIButton *hamburgerButton;
@property (weak, nonatomic) IBOutlet UIButton *ownerServicesButton;



- (IBAction)hamburgerPushed:(id)sender;

- (void) setMenuSizesAndPositions;

- (void) expandHamburger;
- (void) contractHamburger;

@end
