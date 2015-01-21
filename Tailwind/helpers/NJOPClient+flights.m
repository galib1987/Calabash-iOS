//
//  NJOPClient+flights.m
//  Tailwind
//
//  Created by netjets on 12/18/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPClient+flights.h"

@implementation NJOPClient (flights)

- (NSString *) getBrief {
    //NNNOAuthClient *userSession = [NNNOAuthClient sharedInstance];
    // let's see if we have session data
    //NSLog(@"Session DATA: %@",userSession.session);
    //[self getBriefURL:userSession.credential.accessToken];
    return @"";
}

- (NSString *) getBriefURL:(NSString *) accessToken {
    NSString *urlString = @"";
    //NSString *urlString = [NSString stringWithFormat:@"%@%@?appAgent=%@&access_token=%@",API_HOSTNAME, URL_BRIEF,API_SOURCE_IDENTIFIER,accessToken];
    return urlString;
}

@end
