# Mapbox GL for iOS Demo/Template

A [Mapbox GL for iOS](https://github.com/mapbox/mapbox-gl-native) demo/template app to help developers get started with minimal effort.

![Would be nice to live in London, wouldn't it.](https://cloud.githubusercontent.com/assets/1198851/7786397/b7b2cf6c-0180-11e5-88cd-58647bbe3591.png)

## Getting started

1.  Clone or [download](https://github.com/friedbunny/mbgl-ios-demo/archive/master.zip) this repository
1. Run `pod install` to download the Mapbox GL library via [Cocoapods](https://cocoapods.org)
1. Open `mbgl-ios-demo.xcworkspace` in Xcode
1. Insert your [Mapbox access token](https://www.mapbox.com/developers/api/#access-tokens) into Map View’s Attributes Inspector panel in Interface Builder: ![Interface Builder has lots of names for things that you'll never know about](https://cloud.githubusercontent.com/assets/1198851/7786331/4b227e8e-017a-11e5-9b27-bf3428cef7e9.png)
1. Build amazing cartographic things

## Don’t like storyboards?

This demo/template uses storyboards, but you don’t have to: [here’s an example of programmatic instantiation](https://github.com/mapbox/mapbox-gl-native/blob/b7b4515d4883f7da1fdcfb4d5aff7a2f3118ae86/ios/app/MBXViewController.mm#L55-L59) from the official demo app.

## Need help?

If you haven’t already, read the [official project overview from Mapbox](https://www.mapbox.com/mapbox-gl-ios/) and have a look at the [API reference](https://www.mapbox.com/mapbox-gl-ios/api/). The [Mapbox tag on Stack Overflow](http://stackoverflow.com/questions/tagged/mapbox) is a great place to ask questions (that are often answered by Mapboxers). If you’re really stumped, Mapbox also offers [official support via email](https://www.mapbox.com/help/).

## Found a bug?

If you’ve found a bug in the Mapbox GL library, please take a bit to [report it at the main Mapbox GL Native project](https://github.com/mapbox/mapbox-gl-native/issues).