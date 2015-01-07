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
    //self.bgImage.frame = self.bgImage.frame.size.height;
//    self.bgImage.bounds.size.height = self.bgImage.bounds.size.width;
    self.headerLabel.text = [self.headerLabel.text uppercaseString];
    
    if (self.showButtons) {
        [self.buttonA setTitle:[self.buttonAText uppercaseString] forState:UIControlStateNormal];
        [self.buttonB setTitle:[self.buttonBText uppercaseString] forState:UIControlStateNormal];
        self.buttonA.layer.borderColor = [[UIColor whiteColor] CGColor];
    } else {
        self.buttonA.hidden = true;
        self.buttonB.hidden = true;
    }
    
    self.view.backgroundColor = [UIColor clearColor];
    /*NSLog(@"%f", self.bgImage.layer.cornerRadius);
    NSLog(@"%f", self.bgImage.frame.size.width);
    NSLog(@"%f", self.bgImage.frame.size.height);*/
    self.maskHole.layer.masksToBounds = true;
    /*self.bgImage.layer.borderWidth = 5.0;
    self.bgImage.layer.borderColor = [UIColor grayColor].CGColor;*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidLayoutSubviews {
    // After autolayout is done
    self.maskHole.layer.cornerRadius = self.maskHole.layer.bounds.size.width/2;
}

- (void)handleScroll:(CGFloat) offset {
    //NSLog(@"%f", offset);
    CGFloat percentage = 1+offset/self.view.frame.size.width;
    
    CGFloat offscreenWidth = self.bgImage.frame.size.width-self.maskHole.frame.size.width;
    CGFloat offscreenHeight = self.bgImage.frame.origin.y;
    [self.bgImage setFrame:CGRectOffset(self.bgImage.bounds, (percentage-1)*150-offscreenWidth/2, offscreenHeight)];
    //NSLog(@"the offset for %d is %f", self.pageIndex, (percentage)*50);
    
    if (!self.displayed) {
        [self fadeInDownItem:self.headerLabel toPercentage:percentage];
        [self fadeInDownItem:self.descLabel toPercentage:percentage];
    }
    /*self.debuga.text = [NSString stringWithFormat: @"%.2f", percentage];
    self.debugb.text = [NSString stringWithFormat: @"%.2f", percentage];*/
    
}

- (void)fadeInDownItem:(UIView *) item toPercentage:(CGFloat) percentage {
    CGFloat curvedPercentage = pow(fabsf(percentage), 3); // Cubed for ease out
    item.alpha = curvedPercentage;
    [item setTransform:CGAffineTransformMakeTranslation(0, (curvedPercentage-1)*15)];
    //NSLog(@"bounds: %f", item.layer.bounds.origin.y);
}

- (void)transitionIn {
    /*if (!self.displayed) {
        [self fadeInDownItem:self.headerLabel];
        [self fadeInDownItem:self.descLabel];
    }*/
}

- (void)didFinishDisplay {
    self.displayed = true;
}

@end
