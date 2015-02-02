//
//  NJOPContainerHolderViewController.h
//  Tailwind
//
//  Created by netjets on 1/26/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPReservation.h"
#import "NJOPMenuViewController.h"
#import "NJOPNavigationController.h"

@protocol NJOPContainerHolderViewControllerDelegate <NSObject>
- (void) notifySubStoryboard; // this is the delegate to send notification to the storyboard
@end


@interface NJOPContainerHolderViewController : UIViewController <NJOPNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *parallaxBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *containerHolderView;
@property (weak, nonatomic) IBOutlet UIView *basicContainerView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIView *menuView;


@property (nonatomic, retain) NJOPMenuViewController *njopMenuViewController;
@property (nonatomic, retain) UIViewController *currentViewController;
@property (nonatomic, retain) NSMutableArray *subScreenHistory;
@property (nonatomic, retain) NJOPReservation *reservation;

@property (nonatomic, assign) id delegate; // the delegate

- (IBAction)goBack:(id)sender;


#pragma mark - subscreen lifecycle
- (void) goChangeSubScreen:(NSNotification *)aNotification;
- (void) presentSubScreenViewController:(UIViewController *)vc; // loads in the sub screen viewController
- (void) removeCurrentSubScreenViewController;
- (CGRect) frameSubScreenViewController;
- (void) pushViewController:(NSString *) storyboardName withVC:(NSString *) viewControllerName;
- (NSDictionary *) popViewController;

#pragma mark - display methods
- (void) updateHeaderLabel:(NSString *) label;
- (void) displayBackButton;

@end
