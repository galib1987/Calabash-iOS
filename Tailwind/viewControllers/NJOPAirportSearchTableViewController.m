//
//  NJOPAirportSearchTableViewController.m
//  Tailwind
//
//  Created by Angus.Lo on 1/14/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPAirportSearchTableViewController.h"

@interface NJOPAirportSearchTableViewController ()

@end

@implementation NJOPAirportSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource {
    
    // STUB TO SHOW AIRPORT RESULTS
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"resultItem",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"locationLabel.text" : [@"Las Vegas, NV, US" uppercaseString],
                                                  @"airportNameLabel.text" : @"KLAS\nMcCarran International",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"resultItem",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"locationLabel.text" : [@"New York-kennedym ny, us" uppercaseString],
                                                  @"airportNameLabel.text" : @"KJFK\nJohn F Kennedy International",
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"resultItem",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"locationLabel.text" : [@"Green bay, wi, us" uppercaseString],
                                                  @"airportNameLabel.text" : @"KGRB\nAustin Straubel International",
                                                  }
                                          }
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
}

-(void)searchWith:(NSString *)term {
    
    // STUB TO SHOW ABILITY TO RECEIVE TEXTFIELD TEXT
    
    if ([term isEmptyOrWhitespace]) {
        
        self.headerLabel.text = @"Recent Airports:";
        [self loadDataSource];
        
    } else {
    
        self.headerLabel.text = @"Search results:";
        NSArray* sections = @[
                              @{
                                  kSimpleDataSourceSectionCellsKey : @[
                                          @{
                                              kSimpleDataSourceCellIdentifierKey			: @"resultItem",
                                              kSimpleDataSourceCellKeypaths					: @{
                                                      @"locationLabel.text" : [@"AUstin, TX, US" uppercaseString],
                                                      @"airportNameLabel.text" : @"KAUS: Austin-Bergstrom\nInternational",
                                                      }
                                              },
                                          @{
                                              kSimpleDataSourceCellIdentifierKey			: @"resultItem",
                                              kSimpleDataSourceCellKeypaths					: @{
                                                      @"locationLabel.text" : [@"Green bay, wi, us" uppercaseString],
                                                      @"airportNameLabel.text" : @"KGRB\nAustin Straubel International",
                                                      }
                                              }
                                          ]
                                  }
                              ];
        
        self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    }
    
    [self.tableView reloadData];
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
