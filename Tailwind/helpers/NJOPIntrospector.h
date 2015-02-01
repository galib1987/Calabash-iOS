//
//  NJOPIntrospector.h
//  Tailwind
//
//  Created by netjets on 1/23/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJOPIntrospector : NSObject

+ (BOOL)isObjectArray:(id)object;
+ (BOOL)isObjectDictionary:(id)object;

@end
