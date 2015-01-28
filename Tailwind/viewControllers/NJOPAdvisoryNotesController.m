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

@interface NJOPAdvisoryNotesController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation NJOPAdvisoryNotesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.frame = self.view.bounds;
    
//    NJOPFlightHTTPClient *apiClient = [NJOPFlightHTTPClient sharedInstance];
//    
//    NSString *reservationId = [self.reservation.reservationId stringValue];
//    NSString *requestId = [self.reservation.requestId stringValue];
//    
//    self.webView.delegate = self;
//    [apiClient loadAdvisoryWithReservation:reservationId
//                                andRequest:requestId
//                                completion:^(NSString *advisoryNotes, NSError *error) {
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                        [self.webView loadHTMLString:advisoryNotes baseURL:nil];
//                                    });
//                                }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"advisorynotes" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)loadDataSource {
//    
//    NSArray *sections = @[
//                          @{
//                              kSimpleDataSourceSectionCellsKey : @[
//                                      @{
//                                          kSimpleDataSourceCellIdentifierKey			: @"TSA Screening Required",
//                                          },
//                                      @{
//                                          kSimpleDataSourceCellIdentifierKey			: @"List of Prohibited Items",
//                                          },
//                                      @{
//                                          kSimpleDataSourceCellIdentifierKey			: @"MedAire: Worldwide Medical and Travel Support",
//                                          },
//                                      ]
//                              }
//                          ];
//    
//    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
//    self.dataSource.title = @"ADVISORY NOTES";
//}
//
//+ (NSString *)scanString:(NSString *)string
//                startTag:(NSString *)startTag
//                  endTag:(NSString *)endTag
//{
//    
//    NSString* scanString = @"";
//    
//    if (string.length > 0) {
//        
//        NSScanner* scanner = [[NSScanner alloc] initWithString:string];
//        
//        @try {
//            [scanner scanUpToString:startTag intoString:nil];
//            scanner.scanLocation += [startTag length];
//            [scanner scanUpToString:endTag intoString:&scanString];
//        }
//        @catch (NSException *exception) {
//            return nil;
//        }
//        @finally {
//            return scanString;
//        }
//        
//    }
//    
//    return scanString;
//    
//}

@end
