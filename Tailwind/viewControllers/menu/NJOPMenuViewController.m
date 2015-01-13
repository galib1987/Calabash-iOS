//
//  NJOPMenuViewController.m
//  Tailwind
//
//  Created by Netjets on 1/8/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPMenuViewController.h"

@interface NJOPMenuViewController ()

@end

@implementation NJOPMenuViewController

- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hambergerViewController = nil;
    self.OSViewController = nil;
    [self setMenuSizesAndPositions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setMenuSizesAndPositions {
    float buttonHeight = 55.0;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    self.screenWidth = screenSize.width;
    self.screenHeight = screenSize.height;
    float y = self.screenHeight - buttonHeight;
    //y = 50.0;
    //NSLog(@"y is: %f / width is: %f",y,self.screenWidth);
    self.view.frame = CGRectMake(0.0, y, self.screenWidth, buttonHeight);
    
    self.buttonState = menuButtonNone;
}

- (void) resetButtonState {
    self.buttonState = menuButtonNone;
}

#pragma mark -- Hamburger button handling
- (IBAction)hamburgerPushed:(id)sender {
    if (self.buttonState == menuButtonNone) {
        [self expandHamburger];
    } else if (self.buttonState == menuButtonOwnerServices) {
        [self contractOS];
        [self expandHamburger];
    } else {
        [self contractHamburger];
    }
}

- (void) expandHamburger {
    if (self.hambergerViewController == nil) {
        self.hambergerViewController = [[NJOPHamburgerViewController alloc] initWithNibName:@"NJOPHamburgerViewController" bundle:nil];
        self.hambergerViewController.delegate = self;
    }
    //make sure we have the oright coordinates
    CGRect rect = self.view.frame;
    

    // initial position
    self.hambergerViewController.view.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, self.hambergerViewController.view.frame.size.height);
    
    NSLog(@"y=%f / w=%f / h=%f",rect.origin.y,rect.size.width,self.hambergerViewController.view.frame.size.height);

    // add to parent view
    UIView *parentView = [self.view superview];
    [parentView insertSubview:self.hambergerViewController.view belowSubview:self.view];

    // final position
    float finalY = rect.origin.y - self.hambergerViewController.view.frame.size.height;
    CGRect final = CGRectMake(rect.origin.x, finalY, rect.size.width, self.hambergerViewController.view.frame.size.height);

    [UIView animateWithDuration:0.3 animations:^{
        self.hambergerViewController.view.frame = final;
    } completion:^(BOOL finished) {
        // eventually, do something here
        self.buttonState = menuBUttonHamburger;
    } ];
}

- (void) contractHamburger {
    //make sure we have the oright coordinates
    CGRect rect = self.view.frame;
    
    // add to parent view
    //UIView *parentView = [self.view superview];
    //[parentView insertSubview:self.hambergerViewController.view belowSubview:self.view];
    
    // final position
    float finalY = rect.origin.y;
    CGRect final = CGRectMake(rect.origin.x, finalY, rect.size.width, self.hambergerViewController.view.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hambergerViewController.view.frame = final;
    } completion:^(BOOL finished) {
        // eventually, do something here
        self.buttonState = menuButtonNone;
    } ];
}

- (void) contractOS {
    
    CGRect rect = self.view.frame;
    
    float finalY = rect.origin.y;
    CGRect final = CGRectMake(rect.origin.x, finalY, rect.size.width, self.OSViewController.view.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.OSViewController.view.frame = final;
    } completion:^(BOOL finished) {
        self.buttonState = menuButtonNone;
    } ];
}

- (void) expandOS {
    if (self.OSViewController == nil) {
        self.OSViewController = [[NJOPOSViewController alloc] initWithNibName:@"NJOPOSViewController" bundle:nil];
        self.OSViewController.delegate = self;
    }
    //make sure we have the oright coordinates
    CGRect rect = self.view.frame;
    
    
    // initial position
    self.OSViewController.view.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, self.OSViewController.view.frame.size.height);
    
    NSLog(@"y=%f / w=%f / h=%f",rect.origin.y,rect.size.width,self.OSViewController.view.frame.size.height);
    
    // add to parent view
    UIView *parentView = [self.view superview];
    [parentView insertSubview:self.OSViewController.view belowSubview:self.view];
    
    // final position
    float finalY = rect.origin.y - self.OSViewController.view.frame.size.height;
    CGRect final = CGRectMake(rect.origin.x, finalY, rect.size.width, self.OSViewController.view.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.OSViewController.view.frame = final;
    } completion:^(BOOL finished) {
        // eventually, do something here
        self.buttonState = menuButtonOwnerServices;
    } ];
}

- (void) resetButtonState {
    self.buttonState = menuButtonNone;
}

- (IBAction)ownerServiesPushed:(id)sender {
    NSLog(@"OWNER SERVICES PUSHED PUSHED");
    if (self.buttonState == menuButtonNone) {
        [self expandOS];
    } else {
        [self contractOS];
    }
}
@end
