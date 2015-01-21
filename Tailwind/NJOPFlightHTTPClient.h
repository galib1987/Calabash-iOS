//
//  NJOPHTTPClient.h
//  Tailwind
//
//  Created by Chad Long on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPFlightHTTPClient.h"

@interface NJOPFlightHTTPClient : NCLHTTPClient

+ (NJOPFlightHTTPClient*)sharedInstance;

- (void)loadBrief;
- (void)loadFlights;

@end
