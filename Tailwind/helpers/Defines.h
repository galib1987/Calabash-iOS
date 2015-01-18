//
//  Defines.h
//  Tailwind
//
//  Created by netjets on 12/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#ifndef Tailwind_Defines_h
#define Tailwind_Defines_h

// just setting some globals for the app.. mainly for NSNotification
#define dismissKeyboard @"dismissKeyboard" // anytime you want to set a way to dismiss the keyboard when tapped out of the area
#define changeScreen @"changeScreen"
#define goToLoginScreen @"goToLoginScreen"
#define goToHomeScreen @"goToHomeScreen"
#define menuStoryboardName @"menuStoryboardName" // this is used in the NSNotification to define the storyboard name to use to load the storyboard
#define menuViewControllerName @"venuViewControlelrName" // this is used in the NSNotification to define the viewController name to use to get and add in a viewController
#define menuShouldHideMenu @"menuShouldHideMenu" // this is to see if we should add in the menu or not. For example, Welcome screen and login screens don't need menus


// hostname and URL for different API calls
#define API_SOURCE_IDENTIFIER @"OwnersPortalIOSUser"
#define API_HOSTNAME @"servicesdev2.netjets.com"
#define URL_BRIEF @"/op/v1/brief"
#define URL_RESERVATIONS @"/op/v1/reservations"
#define URL_CONTRACTS @"/op/v1/contracts"
#define URL_WEATHER @"/op/v1/weather"
#define URL_FLIGHTS @"/op/v1/flights"


// global enums

typedef enum {
    menuButtonNone = 0,
    menuBUttonHamburger,
    menuButtonOwnerServices
} menuButtonStates;

typedef NS_ENUM(NSInteger, FlightState) {
    flightScheduled = 0,
    flightUpcoming,
    flightCurrent,
    noFlight
};

// temporarily until I figure out a better way to bypass having to VPN
// 0 is use VPN
// 1 is use JSON
#define USE_STATIC_DATA 0
//#define USE_STATIC_DATA 1

#endif
