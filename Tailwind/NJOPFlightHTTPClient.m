//
//  NJOPHTTPClient.m
//  Tailwind
//
//  Created by Chad Long on 1/15/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPFlightHTTPClient.h"
#import "NJOPOAuthClient.h"

@implementation NJOPFlightHTTPClient

#pragma mark - base implementation

+ (NJOPFlightHTTPClient*)sharedInstance
{
    static dispatch_once_t pred;
    static NJOPFlightHTTPClient *sharedInstance = nil;
    
    dispatch_once(&pred, ^{

        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSString*)host
{
    return API_HOSTNAME;
}

- (NSString*)basePath
{
    return API_BASEPATH;
}

- (NCLOAuthClient*)oAuthClient
{
    return [NJOPOAuthClient sharedInstance];
}

- (void)loadBrief
{
    NCLURLRequest *request = [self urlRequestWithPath:@"/brief"];
//    request.shouldOutputTraceLog = YES;
    
    [self GET:request parameters:nil completionBlock:^(NSData *data, NSError *error) {

        // ***** this block is executed on a background thread
        
        if (error)
        {

        }
        else
        {
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            // parse & save to core data here
        }
        
    }];
}

- (void)loadFlights
{
    NCLURLRequest *request = [self urlRequestWithPath:@"/flights"];
    NSDictionary *queryParams = @{@"accountIds":@"1003623", @"showAllFlights":@"true"};
    //    request.shouldOutputTraceLog = YES;
    
    [self GET:request parameters:queryParams completionBlock:^(NSData *data, NSError *error) {
        
        // ***** this block is executed on a background thread
        
        if (error)
        {
            
        }
        else
        {
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            // parse & save to core data here
        }
        
    }];
}


@end
