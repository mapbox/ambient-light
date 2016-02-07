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
    //   * Info.plist via the `MGLMapboxAccessToken` key
    //
    // See https://www.mapbox.com/help/create-api-access-token/ for more information about Mapbox access tokens.
    //
    
    [MGLAccountManager setAccessToken:@"<#mapbox-access-token-here#>"];

    return YES;
}

@end
