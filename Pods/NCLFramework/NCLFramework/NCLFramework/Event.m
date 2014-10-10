//
//  Event.m
//  NCLFramework
//
//  Created by Chad Long on 9/19/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import "Event.h"
#import "EventDetail.h"


@implementation Event

@dynamic action;
@dynamic createdTS;
@dynamic elapsedTime;
@dynamic errorCode;
@dynamic transactionID;
@dynamic component;
@dynamic value;
@dynamic eventDetail;

- (NSString *)description
{
    NSString *errorString = (self.errorCode && [self.errorCode intValue] != 0) ? [NSString stringWithFormat:@" | %@", [self.errorCode stringValue]] : @"";

    return [NSString stringWithFormat:@"%@ | %@ | %@ | %@%@\n", self.createdTS.description, self.component, self.action, self.value, errorString];
}

@end