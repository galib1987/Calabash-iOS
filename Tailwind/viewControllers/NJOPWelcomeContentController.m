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
    self.maskHole.layer.cornerRadius = self.maskHole.frame.size.width/2;
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

- (void)handleScroll {
    //NSLog(@"%lu", self.pageIndex);
}

- (void)fadeInDownItem:(UIView *) item {
    CGRect origPosition = item.frame;
    CGRect newPosition = origPosition;
    newPosition.origin.y -= 15;
    item.frame = newPosition;
    item.alpha = 0;
    [UIView animateWithDuration: 0.5
                          delay: 0.2
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         item.frame = origPosition;
                         item.alpha = 1;
                     }
                     completion: nil];
}

- (void)transitionIn {
    if (!self.displayed) {
        [self fadeInDownItem:self.headerLabel];
        [self fadeInDownItem:self.descLabel];
    }
    self.displayed = true;
}

@end
