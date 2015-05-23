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
}

@end
