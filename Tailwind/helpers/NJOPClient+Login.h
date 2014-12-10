//
//  NJOPClient+Login.h
//  NetJets
//
//  Created by Amos Elmaliah on 9/26/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "NJOPClient.h"
#import "NJOPValidator.h"
#import "BFTask.h"

#define USERNAME_VALIDATION @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
#define PASSWORD_VALIDATION @"^[A-Za-z]{5,}$"

@interface NJOPLoginViewUserInput : NSObject <NJOPValidator>
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* password;
@end

@interface NJOPClient (Login)
+(id<Task>)loginWithUserInputs:(NJOPLoginViewUserInput*)userInput;
@end
