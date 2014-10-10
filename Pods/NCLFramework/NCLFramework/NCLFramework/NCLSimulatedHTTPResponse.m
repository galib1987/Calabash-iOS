//
//  NCLSimulatedHTTPResponse.m
//  Pods
//
//  Created by Chad Long on 2/19/14.
//
//

#import "NCLSimulatedHTTPResponse.h"

@implementation NCLSimulatedHTTPResponse

+ (id)simulatedHTTPResponseWithData:(NSData*)data
                   httpResponseCode:(NSInteger)httpResponseCode
                              error:(NSError*)error
{
    NCLSimulatedHTTPResponse *response = [[NCLSimulatedHTTPResponse alloc] init];
    response.data = data;
    response.httpResponseCode = httpResponseCode;
    response.error = error;
    response.responseDelay = 3.0;
    
    return response;
}

@end