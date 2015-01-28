//
//  NJOPSettingsManager.m
//  Tailwind
//
//  Created by Amin Heidari on 1/26/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPSettingsManager.h"

#define kSettingsManagerUserDefaults						@"kSettingsManagerUserDefaults"
#define kSettingsManagerUserDefaultsDateFormat				@"kSettingsManagerUserDefaultsDateFormat"
#define kSettingsManagerUserDefaultsTemperatureFormat		@"kSettingsManagerUserDefaultsTemperatureFormat"
#define kSettingsManagerUserDefaultsDistanceFormat			@"kSettingsManagerUserDefaultsDistanceFormat"

@implementation NJOPSettingsManager

static NSDateFormatter *us_dateFormatter;
static NSDateFormatter *eu_dateFormatter;

+ (void)initialize
{
	us_dateFormatter = [[NSDateFormatter alloc] init];
	us_dateFormatter.dateFormat = @"EEEE MMM dd yyyy";
	eu_dateFormatter = [[NSDateFormatter alloc] init];
	eu_dateFormatter.dateFormat = @"EEEE dd MMM yyyy";
}

+ (instancetype)sharedInstance
{
	static NJOPSettingsManager *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[NJOPSettingsManager alloc] init];
	});
	return instance;
}

- (instancetype)init
{
	self = [super init];
	
	NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kSettingsManagerUserDefaults];
	if (!dictionary) {
		// initialize properties
		self.dateFormat = NJOPSettingsManagerDateFormatUS;
		self.temperatureFormat = NJOPSettingsManagerTemperatureFormatF;
		self.distanceFormat = NJOPSettingsManagerDistanceFormatMiles;
		
		// persist them
		[self persistCurrentSettings];
	} else {
		// initialize properties from the dictionary
		self.dateFormat = (NJOPSettingsManagerDateFormat)[dictionary[kSettingsManagerUserDefaultsDateFormat] integerValue];
		self.temperatureFormat = (NJOPSettingsManagerTemperatureFormat)[dictionary[kSettingsManagerUserDefaultsTemperatureFormat] integerValue];
		self.distanceFormat = (NJOPSettingsManagerDistanceFormat)[dictionary[kSettingsManagerUserDefaultsDistanceFormat] integerValue];
	}
	
	return self;
}

- (void)persistCurrentSettings
{
	NSDictionary *dic = @{
						  kSettingsManagerUserDefaultsDateFormat : [NSNumber numberWithInteger:self.dateFormat],
						  kSettingsManagerUserDefaultsTemperatureFormat : [NSNumber numberWithInteger:self.temperatureFormat],
						  kSettingsManagerUserDefaultsDistanceFormat : [NSNumber numberWithInteger:self.distanceFormat]
						  };
	[[NSUserDefaults standardUserDefaults] setObject:dic forKey:kSettingsManagerUserDefaults];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setDateFormat:(NJOPSettingsManagerDateFormat)dateFormat
{
	_dateFormat = dateFormat;
	[self persistCurrentSettings];
}

- (NSString *)dateFormatDisplay
{
	switch (self.dateFormat) {
		case NJOPSettingsManagerDateFormatUS:
		{
			return @"US";
		}
			break;
			
		case NJOPSettingsManagerDateFormatEU:
		{
			return @"EU";
		}
			break;
			
		default:
			break;
	}
}

- (void)setTemperatureFormat:(NJOPSettingsManagerTemperatureFormat)temperatureFormat
{
	_temperatureFormat = temperatureFormat;
	[self persistCurrentSettings];
}

- (NSString *)temperatureFormatDisplay
{
	switch (self.temperatureFormat) {
		case NJOPSettingsManagerTemperatureFormatF:
		{
			return @"˚F";
		}
			break;
			
		case NJOPSettingsManagerTemperatureFormatC:
		{
			return @"˚C";
		}
			break;
			
		default:
			break;
	}
}

- (void)setDistanceFormat:(NJOPSettingsManagerDistanceFormat)distanceFormat
{
	_distanceFormat = distanceFormat;
	[self persistCurrentSettings];
}

- (NSString *)distanceFormatDisplay
{
	switch (self.distanceFormat) {
		case NJOPSettingsManagerDistanceFormatKilometers:
		{
			return @"Kilometers";
		}
			break;
			
		case NJOPSettingsManagerDistanceFormatMiles:
		{
			return @"Miles";
		}
			break;
			
		default:
			break;
	}
}

- (NSDateFormatter *)dateFormatterForDateFormat:(NJOPSettingsManagerDateFormat)aFormat
{
	switch (self.dateFormat) {
		case NJOPSettingsManagerDateFormatUS:
		{
			return us_dateFormatter;
		}
			break;
			
		case NJOPSettingsManagerDateFormatEU:
		{
			return eu_dateFormatter;
		}
			break;
			
		default:
			break;
	}
	
	return nil;
}

- (NSString *)formatDate:(NSDate *)aDate
{
	switch (self.dateFormat) {
		case NJOPSettingsManagerDateFormatUS:
		{
			return [us_dateFormatter stringFromDate:aDate];
		}
			break;
			
		case NJOPSettingsManagerDateFormatEU:
		{
			return [eu_dateFormatter stringFromDate:aDate];
		}
			break;
			
		default:
			break;
	}
	
	return nil;
}

@end
