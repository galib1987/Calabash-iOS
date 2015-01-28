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

typedef NS_ENUM(NSInteger, NJOPSettingsManagerTemperatureFormat) {
	NJOPSettingsManagerTemperatureFormatF,
	NJOPSettingsManagerTemperatureFormatC
};

typedef NS_ENUM(NSInteger, NJOPSettingsManagerDistanceFormat) {
	NJOPSettingsManagerDistanceFormatMiles,
	NJOPSettingsManagerDistanceFormatKilometers
};

#import <Foundation/Foundation.h>

@interface NJOPSettingsManager : NSObject

@property (nonatomic, assign) NJOPSettingsManagerDateFormat dateFormat;
@property (nonatomic, assign) NSString *dateFormatDisplay;

@property (nonatomic, assign) NJOPSettingsManagerTemperatureFormat temperatureFormat;
@property (nonatomic, assign) NSString *temperatureFormatDisplay;

@property (nonatomic, assign) NJOPSettingsManagerDistanceFormat distanceFormat;
@property (nonatomic, assign) NSString *distanceFormatDisplay;

+ (instancetype)sharedInstance;

- (NSDateFormatter *)dateFormatterForDateFormat:(NJOPSettingsManagerDateFormat)aFormat;

- (NSString *)formatDate:(NSDate *)aDate;

@end
