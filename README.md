# Ambient Light Mapbox iOS Demo

[Mapbox iOS SDK](https://github.com/mapbox/mapbox-gl-native) demo app that demonstrates ambient light-based map styling.

![Would be nice to live in London, wouldn't it.](https://cloud.githubusercontent.com/assets/1198851/7792257/631d2a12-0264-11e5-82c8-0d8a942adaf8.png)

## Getting started

1.  Clone or [download](https://github.com/friedbunny/ambient-light/archive/master.zip) this repository
1. Run `pod install` to download the Mapbox iOS SDK via [Cocoapods](https://cocoapods.org)
1. Open `ambient-light.xcworkspace` in Xcode
1. Insert your [Mapbox access token](https://www.mapbox.com/help/create-api-access-token/) in [`AppDelegate.m`](ambient-light/AppDelegate.m)
1. Build amazing cartographic things

## Detecting ambient light

This is a bit of a lie: Apple does not expose any direct ambient light sensing API to developers, so **this demo uses screen brightness as a proxy**.

This relies on the user having auto brightness enabled, which isn’t always a given (and there’s no easy way to detect if that’s on, either).

Generally this technique works well and is the same that’s used in [Tweetbot](http://tapbots.com/tweetbot/).

## How the UI works

The slider controls the screen brightness threshold at which the map will change styles — e.g., farther left will switch to the dark style at a lower screen brightness.

A reasonable threshold is about 35%, or somewhat left of center.

Current brightness is indicated by a vertical line on top of the slider bar.

![Annoying gif demo](https://cloud.githubusercontent.com/assets/1198851/7792704/71965206-026b-11e5-8388-5e2d0a6cb5f3.gif)

## Does not work in simulator

This does not really work in the simulator as brightness is hardcoded to 50%, but you can still drag the slider to change styles.

## Need help?

If you haven’t already, read the [official project overview from Mapbox](https://www.mapbox.com/ios-sdk/) and have a look at the [API reference](https://www.mapbox.com/ios-sdk/api/). The [Mapbox tag on Stack Overflow](http://stackoverflow.com/questions/tagged/mapbox+ios) is a great place to ask questions (that are often answered by Mapboxers). Mapbox also offers [tons of help resources](https://www.mapbox.com/help/).

## Found a bug?

If you’ve found a bug in the Mapbox iOS SDK, please take a bit to [report it on the project repo](https://github.com/mapbox/mapbox-gl-native/issues).
