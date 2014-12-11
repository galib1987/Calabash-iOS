//
//  NJOPValidator.m
//  OAuthSample
//
//  Created by NetJets on 9/11/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPValidator.h"

@implementation NJOPValidator
@synthesize input=_input;

+(ValidatorBlock)validatorBlockWithRegex:(NSString*)regexString {

	return ^(NSString*string,NSError* error) {
		NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:regexString
																																					 options:0
																																						 error:&error];
		NSUInteger matches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
		// NSLog(@"%@%@%@", (matches ? @"valid:" : @"invalid:"),regexString,string);
		return (BOOL)(matches > 0);
	};
}

+(instancetype)validatorWithRegex:(NSString *)string {
	return [NJOPValidator validatorWithBlock:[self validatorBlockWithRegex:string]];
}

-(instancetype)initWithBlock:(ValidatorBlock)block {
	self = [super init];
	if (self) {
		_block = block;
	}
	return self;
}

+(instancetype)validatorWithBlock:(ValidatorBlock)block {
	return [[self alloc] initWithBlock:block];
}

-(BOOL)validateWithError:(NSError *)error {
	if (_block && _input) {
		return _block(self.input, error);
	}
	return NO;
}

@end
