//
//  ViewController.m
//  ambient-light
//
//  Created by Jason Wray on 5/23/15.
//  Copyright (c) 2015 Mapbox. All rights reserved.
//

#import "ViewController.h"

#import <MapboxGL/MapboxGL.h>

@interface ViewController ()

@property (nonatomic) IBOutlet MGLMapView *mapView;

@property (nonatomic) IBOutlet UISlider *thresholdSlider;
@property (nonatomic) CGFloat switchingThreshold;
@property (nonatomic) CALayer *brightnessIndicator;
//@property (nonatomic) NSURL *lightStyle;
//@property (nonatomic) NSURL *darkStyle;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // NOTE
    // Set your Mapbox Access Token in AppDelegate.m
    
    // set the map to show and follow the user's location (initially)
    self.mapView.userTrackingMode = MGLUserTrackingModeFollow;

    // ambient light map switching
    //
    //self.lightStyle = [NSURL URLWithString:@"asset://styles/light-v7.json"];
    //self.darkStyle = [NSURL URLWithString:@"asset://styles/dark-v7.json"];
    
    self.mapView.styleURL = [NSURL URLWithString:@"asset://styles/lightdark-v7.json"];
    
    self.switchingThreshold = self.thresholdSlider.value;
    
    // set tint to dark grey, for ambiance
    [[UIView appearance] setTintColor:[UIColor colorWithWhite:0.5f alpha:1]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self updateMapStyleForScreenBrightness];
    [self updateBrightnessIndicator];
     
    // Because Apple doesn't provide any API access to the actual ambient light sensor,
    // we have to use screen brightness as a proxy. Clearly this only works if the user
    // has auto-brightness enabled.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(brightnessChanged)
                                                 name:UIScreenBrightnessDidChangeNotification
                                               object:nil];
    
    // update style when app returns to being active
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMapStyleForScreenBrightness)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    // rotate the brightness indicator, too
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateBrightnessIndicator)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (void)brightnessChanged
{
    [self updateMapStyleForScreenBrightness];
    [self updateBrightnessIndicator];
}

- (void)updateMapStyleForScreenBrightness
{
    // map style changes need to happen in the foreground, otherwise the GL view will hang
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        CGFloat brightness = [[UIScreen mainScreen] brightness];
        
        if (self.switchingThreshold > brightness)// && ![self.mapView hasStyleClass:@"dark"])
        {
            [self.mapView removeStyleClass:@"dark"];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
            //NSLog(@"switch to dark (%@)", ([self.mapView hasStyleClass:@"dark"]) ? @"dark" : @"light");
        }
        else if (self.switchingThreshold <= brightness)// && [self.mapView hasStyleClass:@"dark"])
        {
            [self.mapView addStyleClass:@"dark"];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
            //NSLog(@"switch to light (%@)", ([self.mapView hasStyleClass:@"dark"]) ? @"dark" : @"light");
        }
        
        //NSLog(@"fail to switch — %.2f, %@", brightness, ([self.mapView hasStyleClass:@"dark"]) ? @"dark" : @"light");
        
        // UIViewControllerBasedStatusBarAppearance must be set to NO in Info.plist for status bar styling to work
    }
}

- (void)updateBrightnessIndicator
{
    if (!self.brightnessIndicator)
    {
        // setup and place a line to indicate the current brightness
        self.brightnessIndicator = [CALayer layer];
        self.brightnessIndicator.bounds = CGRectMake(0, 0, 2, 25);
        self.brightnessIndicator.position = [self pointOnThresholdSliderForCurrentBrightness];
        self.brightnessIndicator.cornerRadius = 1;
        self.brightnessIndicator.shouldRasterize = YES;
        self.brightnessIndicator.rasterizationScale = [UIScreen mainScreen].scale;
        self.brightnessIndicator.backgroundColor = [UIView appearance].tintColor.CGColor;
        
        // insert in the slider, below its content
        [self.thresholdSlider.layer insertSublayer:self.brightnessIndicator atIndex:0];
    }
    else
    {
        // update the brightness indicator position for current brightness
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        moveAnimation.fromValue = [NSValue valueWithCGPoint:self.brightnessIndicator.position];
        moveAnimation.removedOnCompletion = NO;
        moveAnimation.duration = 0.2;
        moveAnimation.fillMode = kCAFillModeForwards;
        
        self.brightnessIndicator.position = [self pointOnThresholdSliderForCurrentBrightness];
        
        [self.brightnessIndicator addAnimation:moveAnimation forKey:@"move"];
    }
}

- (CGPoint)pointOnThresholdSliderForCurrentBrightness
{
    // get horizontal position for indicator, using brightness (min 0, max 1) as a percentage
    CGFloat x = self.thresholdSlider.layer.bounds.size.width * [[UIScreen mainScreen] brightness];
    
    // get the vertical center of the slider, then place the indicator immediately above
    CGFloat y = (self.thresholdSlider.layer.bounds.size.height / 2) - (self.brightnessIndicator.bounds.size.height / 2);
    
    return CGPointMake(x, y);
}

@end
