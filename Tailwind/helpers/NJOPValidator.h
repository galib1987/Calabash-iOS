//
//  NJOPValidator.h
//  OAuthSample
//
//  Created by Amos Elmaliah on 9/11/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

@import Foundation;

@protocol NJOPValidator <NSObject>
-(BOOL)validateWithError:(NSError*)error;
@property (nonatomic, strong) id input;
@end

typedef BOOL(^ValidatorBlock)(NSString*,NSError*);

@interface NJOPValidator : NSObject<NJOPValidator>
+(instancetype)validatorWithRegex:(NSString*)string;
+(instancetype)validatorWithBlock:(ValidatorBlock)validatorBlock;
@property (copy, nonatomic)ValidatorBlock block;
@end
