# MBLibrary
This framework includes common and useful extensions to variuos classes of the `Foundation`, `UIKit`, `AppKit`, `WatchKit` and other frameworks and some useful wrapper for `UserDefault`, `NSUbiquitousKeyValueStore` and In-App purchase process.

## Project Details
The project includes three target, one for each platform (_iOS_, _macOS_ and _watchOS_): code used by more than platform resides in the `Shared` group, platform specific in the appropriate `MBLibrary *OS` group.

Currently only `Foundation` related code has unit tests shared by all three targets, other code needs tests.

## Usage
Add the project file to the destination project and add the appropriate framework to the _Embedded Binaries_ section in the _General_ tab of your target property.