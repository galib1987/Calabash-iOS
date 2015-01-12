//
//  NJOPSession.h
//  Tailwind
//
//  Created by netjets on 12/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NJOPBrief.h"
#import "NJOPIndividual.h"

@interface NJOPSession : NSObject

@property (nonatomic, assign, readwrite) BOOL isLoggedIn;
@property (nonatomic,retain,readwrite) NJOPBrief *brief; // we're going to keep the latest brief call around here
@property (nonatomic, retain) NJOPIndividual *individual; // keep the individual info here
@property (nonatomic, retain) NSArray *reservations; // we're going to separately keep a list of reservations here

+ (NJOPSession *) sharedInstance ;


@end
