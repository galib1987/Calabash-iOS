//
//  NJOPContactViewController.m
//  Tailwind
//
//  Created by netjets on 1/12/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPContactViewController.h"

@interface NJOPContactViewController ()

@end

@implementation NJOPContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*In theory, this should result in clickable phone numbers. Waiting for VPN token to find out.*/
- (void)callNumberWithString:(NSString *)string {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", string]]];
}

- (IBAction)contactUSPressed:(id)sender {
    [self callNumberWithString:@"18773565823"];
};

- (IBAction)contactEuropePressed:(id)sender {
    [self callNumberWithString:@"4408436349006"];
}

- (IBAction)contactChinaPressed:(id)sender {
    [self callNumberWithString:@"1877565823"];
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
