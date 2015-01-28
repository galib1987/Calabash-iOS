//
//  NJOPAdvisoryNotesController.m
//  Tailwind
//
//  Created by netjets on 1/5/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPAdvisoryNotesController.h"
#import "NJOPAdvisoryNotesCell.h"
#import "NJOPOAuthClient.h"
#import "NJOPFlightHTTPClient.h"

@interface NJOPAdvisoryNotesController ()

@end

@implementation NJOPAdvisoryNotesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NJOPFlightHTTPClient *apiClient = [NJOPFlightHTTPClient sharedInstance];
    
    NSString *reservationId = [self.reservation.reservationId stringValue];
    NSString *requestId = [self.reservation.requestId stringValue];

    [apiClient loadAdvisoryWithReservation:reservationId
                                andRequest:requestId
                                completion:^(NSString *advisoryNotes, NSError *error) {
                                    NSString *parsedHTML = [NJOPAdvisoryNotesController scanString:advisoryNotes
                                                                                          startTag:@"</td>"
                                                                                            endTag:@"</span>"];
                                    NSLog(@"LOOK WHAT I PARSED : %@", parsedHTML);
                                }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataSource {
    
    NSArray *sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"TSA Screening Required",
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"List of Prohibited Items",
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"MedAire: Worldwide Medical and Travel Support",
                                          },
                                      ]
                              }
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"ADVISORY NOTES";
}

+ (NSString *)scanString:(NSString *)string
                startTag:(NSString *)startTag
                  endTag:(NSString *)endTag
{
    
    NSString* scanString = @"";
    
    if (string.length > 0) {
        
        NSScanner* scanner = [[NSScanner alloc] initWithString:string];
        
        @try {
            [scanner scanUpToString:startTag intoString:nil];
            scanner.scanLocation += [startTag length];
            [scanner scanUpToString:endTag intoString:&scanString];
        }
        @catch (NSException *exception) {
            return nil;
        }
        @finally {
            return scanString;
        }
        
    }
    
    return scanString;
    
}

@end
