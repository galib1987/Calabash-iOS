//
//  NJOPAirportSearchViewController.m
//  Tailwind
//
//  Created by Angus.Lo on 1/12/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPAirportSearchViewController.h"

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
    
    [self.view addSubview:self.resultsTable.view];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
