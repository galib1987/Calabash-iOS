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

@property NSUInteger pageIndex;
@property NSString *imageFile;
@property NSString *headerText;
@property NSString *descText;
@property bool displayed;

- (void)handleScroll:(CGFloat) offset;
- (void)fadeInDownItem:(UIView *) item toPercentage:(CGFloat) percentage;
- (void)transitionIn;
- (void)didFinishDisplay;

@end
