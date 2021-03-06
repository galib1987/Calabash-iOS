//
//  NSData+Utility.m
//  NCLFramework
//
//  Created by Chad Long on 10/5/12.
//  Copyright (c) 2012 NetJets, Inc. All rights reserved.
//

#import "NSData+Utility.h"

@implementation NSData (Utility)

#pragma mark - Base 64 encoding

- (NSString*)encodeBase64
{
    const uint8_t* input = (const uint8_t*)[self bytes];
    NSInteger length = [self length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (NSString*)readableStringWithMaxBytes:(NSInteger)maxDisplayBytes
{
    NSError *parseError = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&parseError];
    
    if (parseError ||
        !jsonData)
    {
        NSString *printableData = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
        NSString *moreBytes = printableData.length > maxDisplayBytes ? [NSString stringWithFormat:@"... < %i MORE BYTES >", printableData.length - maxDisplayBytes] : @"";
        printableData = printableData.length > maxDisplayBytes ? [printableData substringToIndex:maxDisplayBytes] : printableData;
        
        return [NSString stringWithFormat:@"%@%@", printableData, moreBytes];
    }
    else
    {
        NSString *prettyPrintJSON = [jsonData description];
        NSString *moreBytes = prettyPrintJSON.length > maxDisplayBytes ? [NSString stringWithFormat:@"... < %i MORE BYTES >", prettyPrintJSON.length - maxDisplayBytes] : @"";
        prettyPrintJSON = prettyPrintJSON.length > maxDisplayBytes ? [prettyPrintJSON substringToIndex:maxDisplayBytes] : prettyPrintJSON;
        
        return [NSString stringWithFormat:@"%@%@", prettyPrintJSON, moreBytes];
    }
}

@end
