//
//  AppDelegate.m
//  ambient-light
//
//  Created by Jason Wray on 5/23/15.
//  Copyright (c) 2015 Mapbox. All rights reserved.
//

#import "AppDelegate.h"

@import Mapbox;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setting the Mapbox access token can happen in one of several places:
    //   * AppDelegate (here)
    //   * Info.plist via a `MGLMapboxAccessToken` key with a string value
    //
    // Read more about Mapbox access tokens: https://www.mapbox.com/help/create-api-access-token/

    [MGLAccountManager setAccessToken:@"<# mapbox-access-token-here #>"];

    NSAssert(![[MGLAccountManager accessToken] isEqualToString:@"<# mapbox-access-token-here #>"], @"You must enter your Mapbox access token in order for this app to load. Look in AppDelegate.h for how to set your access token.");

    return YES;
}

@end
