//
//  NJOPWelcomeContentController.h
//  Tailwind
//
//  Created by netjets on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJOPWelcomeContentController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIView *maskHole;
/*@property (strong, nonatomic) IBOutlet UILabel *debugb;
@property (strong, nonatomic) IBOutlet UILabel *debuga;*/
@property (weak, nonatomic) IBOutlet UIButton *buttonA;
@property (weak, nonatomic) IBOutlet UIButton *buttonB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopSpace;

@property NSUInteger pageIndex;
@property NSString *imageFile;
@property NSString *headerText;
@property NSString *descText;
@property bool displayed;
@property bool showButtons;
@property NSString *buttonAText;
@property NSString *buttonBText;

- (void)handleScroll:(CGFloat) offset;
- (void)fadeInDownItem:(UIView *) item toPercentage:(CGFloat) percentage;
- (void)didFinishDisplay;

@end
