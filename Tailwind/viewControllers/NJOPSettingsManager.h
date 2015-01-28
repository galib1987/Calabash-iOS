//
//  NJOPSettingsManager.h
//  Tailwind
//
//  Created by Amin Heidari on 1/26/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

typedef NS_ENUM(NSInteger, NJOPSettingsManagerDateFormat) {
	NJOPSettingsManagerDateFormatUS,
	NJOPSettingsManagerDateFormatEU
};

#import <Foundation/Foundation.h>

@interface NJOPSettingsManager : NSObject

@property (nonatomic, assign) NJOPSettingsManagerDateFormat dateFormat;
@property (nonatomic, assign) NSString *dateFormatDisplay;

+ (instancetype)sharedInstance;

@end
