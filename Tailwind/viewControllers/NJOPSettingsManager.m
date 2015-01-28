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

@implementation NJOPSettingsManager

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
		
		// persist them
		[self persistCurrentSettings];
	} else {
		// initialize properties from the dictionary
		self.dateFormat = (NJOPSettingsManagerDateFormat)[dictionary[kSettingsManagerUserDefaultsDateFormat] integerValue];
	}
	
	return self;
}

- (void)persistCurrentSettings
{
	NSDictionary *dic = @{
						  kSettingsManagerUserDefaultsDateFormat : [NSNumber numberWithInteger:self.dateFormat]
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

@end
