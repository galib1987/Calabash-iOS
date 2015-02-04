//
//  NJOPSelectAccountViewController.m
//  Tailwind
//
//  Created by netjets on 1/8/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPSelectAccountViewController.h"
#import "NJOPOAuthClient.h"

@interface NJOPSelectAccountViewController ()

@end

@implementation NJOPSelectAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource {
    // STUB to load accounts
    
    
    NJOPOAuthClient *authClient = [NJOPOAuthClient sharedInstance];
    NSLog(@"%@", authClient.accounts);
    
    NSMutableArray *sectionsArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *account in authClient.accounts) {
        NSDictionary *cellRepresentation = @{
                                             kSimpleDataSourceCellIdentifierKey			: @"NJOPAccountTableCell",
                                             kSimpleDataSourceCellKeypaths					: @{
                                                     @"accountNameLabel.text" : account[@"accountName"],
                                                     @"principalNameLabel.text" : [NSString stringWithFormat:@"%@ %@", authClient.individual.firstName, authClient.individual.lastName],
                                                     }
                                             };
        
        [sectionsArray addObject:cellRepresentation];
    }
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : sectionsArray
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = [@"Book a Flight" uppercaseString];
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
