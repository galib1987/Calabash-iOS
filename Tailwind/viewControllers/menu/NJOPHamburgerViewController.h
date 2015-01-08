//
//  NJOPHamburgerViewController.h
//  Tailwind
//
//  Created by David Lin on 1/8/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NJOPHamburgerViewControllerDelegate <NSObject>
- (void) resetButtonState;
@end

@interface NJOPHamburgerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UIButton *messagesButton;
@property (weak, nonatomic) IBOutlet UIButton *flighteButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;

@property (nonatomic, assign) id delegate;



- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)accountButtonPressed:(id)sender;
- (IBAction)messagesButtonPressed:(id)sender;
- (IBAction)filghtsButtonPressed:(id)sender;
- (IBAction)settingsButtonPressed:(id)sender;
- (IBAction)bookButtonPressed:(id)sender;


@end
