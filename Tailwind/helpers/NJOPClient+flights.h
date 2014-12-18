//
//  NJOPClient+flights.h
//  Tailwind
//
//  Created by netjets on 12/18/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPClient.h"
#import "NJOPValidator.h"
#import "NNNOAuthClient.h"
#import "BFTask.h"

@interface NJOPClient (flights)

- (NSString *) getBrief;
- (NSString *) getBriefURL:(NSString *) accessToken;

@end
