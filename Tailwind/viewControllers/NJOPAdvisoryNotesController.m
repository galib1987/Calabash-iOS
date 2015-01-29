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
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation NJOPAdvisoryNotesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NJOPFlightHTTPClient *apiClient = [NJOPFlightHTTPClient sharedInstance];
    
    NSString *reservationId = [self.reservation.reservationId stringValue];
    NSString *requestId = [self.reservation.requestId stringValue];
    
    [apiClient loadAdvisoryWithReservation:reservationId
                                andRequest:requestId
                                completion:^(NSString *advisoryNotes, NSError *error) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self.webView loadHTMLString:advisoryNotes baseURL:nil];
                                    });
                                }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
