//
//  NJOPAccountViewController.m
//  Tailwind
//
//  Created by netjets on 12/30/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPAccountViewController.h"
#import "NJOPOAuthClient.h"

@interface NJOPAccountViewController ()

@end

@implementation NJOPAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataSource {
    
    NSMutableArray *sectionsArray = [[NSMutableArray alloc] initWithArray:@[
                                                                           @{
                                                                               kSimpleDataSourceCellIdentifierKey			: @"YourProfile",
                                                                               kSimpleDataSourceCellKeypaths					: @{
                                                                                       }
                                                                               },
                                                                           @{
                                                                               kSimpleDataSourceCellIdentifierKey			: @"YourPastFlights",
                                                                               kSimpleDataSourceCellKeypaths					: @{
                                                                                       }
                                                                               },
                                                                           @{
                                                                               kSimpleDataSourceCellIdentifierKey			: @"GiveFeedback",
                                                                               kSimpleDataSourceCellKeypaths					: @{
                                                                                       }
                                                                               },
                                                                           @{
                                                                               kSimpleDataSourceCellIdentifierKey			: @"Principal",
                                                                               kSimpleDataSourceCellKeypaths					: @{
                                                                                       }
                                                                               }
                                                                           ]];
    
    
    NJOPOAuthClient *client = [NJOPOAuthClient sharedInstance];
    for (NSDictionary *account in client.accounts) {
        NSDictionary *cellRepresentation = @{
                                             kSimpleDataSourceCellIdentifierKey			: @"Principal",
                                             kSimpleDataSourceCellKeypaths					: @{
                                                @"principalName.text" 				: account[@"accountName"],
                                                 @"accountName.text" 				: [NSString stringWithFormat:@"%@ %@", client.individual.firstName, client.individual.lastName],
                                                     }
                                             };
        
        [sectionsArray addObject:cellRepresentation];
    }
    
    
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : sectionsArray                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"YOUR ACCOUNT";
    
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
