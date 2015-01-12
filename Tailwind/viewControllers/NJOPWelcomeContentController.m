//
//  NJOPWelcomeContentController.m
//  Tailwind
//
//  Created by netjets on 12/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPWelcomeContentController.h"

@interface NJOPWelcomeContentController ()

@end

@implementation NJOPWelcomeContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bgImage.image = [UIImage imageNamed:self.imageFile];
    self.headerLabel.text = self.headerText;
    self.descLabel.text = self.descText;
    self.headerLabel.text = [self.headerLabel.text uppercaseString];
    
    if (self.showButtons) {
        self.titleTopSpace.constant = 20;
        [self.buttonA setTitle:[self.buttonAText uppercaseString] forState:UIControlStateNormal];
        [self.buttonB setTitle:[self.buttonBText uppercaseString] forState:UIControlStateNormal];
        self.buttonA.layer.borderColor = [[UIColor whiteColor] CGColor];
    } else {
        self.buttonA.hidden = true;
        self.buttonB.hidden = true;
        [self.buttonA removeFromSuperview];
        [self.buttonB removeFromSuperview];
    }
    
    self.view.backgroundColor = [UIColor clearColor];
    self.maskHole.layer.masksToBounds = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    // After autolayout is done
    self.maskHole.layer.cornerRadius = self.maskHole.layer.bounds.size.width/2;
}

- (void)handleScroll:(CGFloat) offset {
    CGFloat percentage = 1+offset/self.view.frame.size.width;
    
    CGFloat offscreenWidth = self.bgImage.frame.size.width-self.maskHole.frame.size.width;
    CGFloat offscreenHeight = self.bgImage.frame.origin.y;
    [self.bgImage setFrame:CGRectOffset(self.bgImage.bounds, (percentage-1)*150-offscreenWidth/2, offscreenHeight)];
    
    if (!self.displayed) {
        [self fadeInDownItem:self.headerLabel toPercentage:percentage];
        [self fadeInDownItem:self.descLabel toPercentage:percentage];
    }
    
}

- (void)fadeInDownItem:(UIView *) item toPercentage:(CGFloat) percentage {
    CGFloat curvedPercentage = pow(fabsf(percentage), 3); // Cubed for ease out
    item.alpha = curvedPercentage;
    [item setTransform:CGAffineTransformMakeTranslation(0, (curvedPercentage-1)*15)];
}

- (void)didFinishDisplay {
    self.displayed = true;
}

@end
