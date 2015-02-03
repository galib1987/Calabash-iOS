//
//  NJOPSelectAccountViewController.m
//  Tailwind
//
//  Created by netjets on 1/8/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPSelectAccountViewController.h"
#import "NJOPOAuthClient.h"
#import "NJOPBookingViewController.h"

@interface NJOPSelectAccountViewController ()
@property (nonatomic) NSArray *accountContracts;
@property (nonatomic) NSArray *userAccounts;
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
    self.userAccounts = authClient.accounts;
    self.accountContracts = authClient.contracts;
    
    
    NSMutableArray *sectionsArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *account in self.userAccounts) {
        NSDictionary *cellRepresentation = @{
                                              kSimpleDataSourceCellIdentifierKey			: @"NJOPAccountTableCell",
                                              kSimpleDataSourceCellKeypaths					: @{
                                                      @"accountNameLabel.text" : account[@"accountName"],
                                                      @"principalNameLabel.text" : [NSString stringWithFormat:@"%@ %@", authClient.individual.firstName, authClient.individual.lastName],
                                                      },
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showBooking"]) {
        NJOPBookingViewController *vc = segue.destinationViewController;
        vc.contracts = self.accountContracts;
    }
}


@end
