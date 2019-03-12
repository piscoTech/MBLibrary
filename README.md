# MBLibrary
This framework includes common and useful extensions to variuos classes of the `Foundation`, `UIKit`, `AppKit`, `WatchKit` and other frameworks and some useful wrapper for `UserDefault`, `NSUbiquitousKeyValueStore` and In-App purchase process.

## Project Details
This project is made up of two different frameworks: `MBLibrary` containing various code spanning multiple system frameworks and `MBHealth` containing code related to `HealthKit` whihc cannot be included in the other framework because on the AppStore an app cannot link against `HealthKit` if the functionality is not used.

The `MBLibrary` framework has three targets, one for each platform (_iOS_, _macOS_ and _watchOS_) and `MBHealth` has two (_iOS_ and _watchOS_): code used by more than one target resides in the `Shared` group, platform/target specific in the appropriate `MBLibrary *OS` or `MBHealth *OS` group.

Currently only `Foundation` related code has unit tests shared by all three targets, other code needs tests.

## Usage
Add the project file to the destination project and add the appropriate framework to the _Embedded Binaries_ section in the _General_ tab of your target property.

If you include `MBHealth` you must include also the corresponding `MBLibrary` framework.
