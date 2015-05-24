//
//  ViewController.m
//  mbgl-demo-ios
//
//  Created by Jason Wray on 5/23/15.
//  Copyright (c) 2015 Mapbox. All rights reserved.
//

#import "ViewController.h"

#import <MapboxGL/MapboxGL.h>

@interface ViewController () <MGLMapViewDelegate>

@property (nonatomic) IBOutlet MGLMapView *mapView;

@property (nonatomic) IBOutlet UISlider *thresholdSlider;
@property (nonatomic) CGFloat switchingThreshold;
@property (nonatomic) NSURL *lightStyle;
@property (nonatomic) NSURL *darkStyle;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // NOTE
    // Set your Mapbox Access Token via the Storyboard, in the Attributes Inspector panel for Map View
    
    // set the map to show and follow the user's location (initially)
    self.mapView.userTrackingMode = MGLUserTrackingModeFollow;
    
    // hooks up the delegate, not used or necessary here (but a convenient example)
    self.mapView.delegate = self;
    

    // ambient light map switching
    //
    self.lightStyle = [NSURL URLWithString:@"asset://styles/light-v7.json"];
    self.darkStyle = [NSURL URLWithString:@"asset://styles/dark-v7.json"];
    
    self.switchingThreshold = self.thresholdSlider.value;
    
    [self updateMapStyleForScreenBrightness];
    
    // Because Apple doesn't provide any API access to the actual ambient light sensor,
    // we have to use screen brightness as a proxy. Clearly this only works if the user
    // has auto-brightness enabled.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMapStyleForScreenBrightness)
                                                 name:UIScreenBrightnessDidChangeNotification
                                               object:nil];
    
    // update style when app returns to being active
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMapStyleForScreenBrightness)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    // set tint to dark grey, for ambiance
    [[UIView appearance] setTintColor:[UIColor colorWithWhite:0.5f alpha:1]];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)thresholdSliderChanged:(UISlider *)sender
{
    self.switchingThreshold = sender.value;
    [self updateMapStyleForScreenBrightness];
}

- (void)updateMapStyleForScreenBrightness
{
    // map style changes need to happen in the foreground, otherwise the GL view will hang
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        CGFloat brightness = [[UIScreen mainScreen] brightness];
        
        if (self.switchingThreshold > brightness && ![self.mapView.styleURL isEqual:self.darkStyle])
        {
            self.mapView.styleURL = self.darkStyle;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        }
        else if (self.switchingThreshold < brightness && ![self.mapView.styleURL isEqual:self.lightStyle])
        {
            self.mapView.styleURL = self.lightStyle;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        }
        
        // UIViewControllerBasedStatusBarAppearance must be set to NO in Info.plist for status bar styling to work
    }
}

@end
