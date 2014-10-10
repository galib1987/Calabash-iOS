//
//  NCLSimulatedHTTPResponse.h
//  Pods
//
//  Created by Chad Long on 2/19/14.
//
//

//#import <Foundation/Foundation.h>

@interface NCLSimulatedHTTPResponse : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic) NSInteger httpResponseCode;
@property (nonatomic, strong) NSError *error;
@property (nonatomic) NSTimeInterval responseDelay;

+ (id)simulatedHTTPResponseWithData:(NSData*)data
                   httpResponseCode:(NSInteger)httpResponseCode
                              error:(NSError*)error;

@end