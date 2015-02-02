//
//  NJOPAirportSearchViewController.m
//  Tailwind
//
//  Created by Angus.Lo on 1/12/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPAirportSearchViewController.h"
#import "NJOPTextField.h"
#import "NJOPConfig.h"

@interface NJOPAirportSearchViewController ()

@end

@implementation NJOPAirportSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.searchInput becomeFirstResponder];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    NJOPAirportSearchTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BookingAirportResults"];
    self.resultsTable = vc;
    self.resultsTable.editingDeparture = self.editingDeparture;
    
    [self.view addSubview:self.resultsTable.view];
    
    
    // tap gesture to dismiss keyboard
    // we put this on any UIView that we want to be able to dismiss keyboard from
    // also copy the tapGesture method from below
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[NJOPConfig sharedInstance] action:@selector(hideKeyboard)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidLayoutSubviews {
    // Lay out results table
    CGFloat resultsTop = self.searchInput.frame.origin.y+self.searchInput.frame.size.height+10;
    CGFloat resultsHeight = self.view.frame.size.height-resultsTop;
    self.resultsTable.view.frame = CGRectMake(self.searchInput.frame.origin.x, resultsTop, self.searchInput.frame.size.width, resultsHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchEdited:(NJOPTextField *)sender {
    [self.resultsTable searchWith:sender.text];
}

- (void)viewWillDisappear:(BOOL)animated {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    [super viewWillDisappear:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
