[English](https://github.com/aromajoin/aromashooter-sdk-ios) / [日本語](README-JP.md)

# Aroma Shooter SDK (iOS)

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg?style=flat-square)](https://github.com/aromajoin/aromashooter-sdk-ios/releases)
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg?style=flat-square)](https://www.apache.org/licenses/LICENSE-2.0.html) 
[![Join the community on Spectrum](https://withspectrum.github.io/badge/badge.svg)](https://spectrum.chat/aromajoin-software/)


**The iOS version of AromaShooterController SDK which is used to communicate with [Aroma Shooter devices](https://aromajoin.com/products/aroma-shooter)**.

> **v2.0.0 is a breaking release.** The `diffuse*` methods are renamed to `shoot*`, the `CartridgePort` model becomes `AromaChamber` (`intensityPercent` → `concentration`), and the `booster`/`fan` parameters become `internalBooster`/`externalBooster`. See the [CHANGELOG](sample/AromaShooterSDKSample/AromaShooterSwiftSDK.xcframework/ios-arm64/AromaShooterSwiftSDK.framework/CHANGELOG.md).

# Table of Contents
1. [Supported devices](#supported-devices)  
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Usage](#usage)
    * [Connect/Disconnect devices](#connectdisconnect-devices)
    * [Get connected devices](#get-connected-devices)
    * [Shoot scents](#shoot-scents)
    * [Stop shooting](#stop)
5. [License](#license)

## Supported devices
* Aroma Shooter Bluetooth version 

## Prerequisites
* iOS version: >= 12.0
* Swift version: >= 5.0

## Installation  
* Download the [`AromaShooterSwiftSDK.xcframework` at the release page](https://github.com/aromajoin/aromashooter-sdk-ios/releases).  
* Drag and drop it into your project, then set it to **Embed & Sign** under your target's *General → Frameworks, Libraries, and Embedded Content*.

Watch a [video walkthrough](https://youtu.be/MepAhofA9PE) of this process to simplify your life.

## Usage

### Add Bluetooth usage description to `Info.plist` file
From iOS 13 and later, it is required to add the Bluetooth usage description, if not the app will be crashed.
So, please add the key and its value to the app's `Info.plist` file.
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>The app uses Bluetooth to connect to Aroma Shooter</string>
```

Besides, if you get the "Target Integrity" in XCode 12.3, please check out the solution [here](https://github.com/aromajoin/aromashooter-sdk-ios/issues/5).

### Get Controller references
* Import Controller module
```swift
import AromaShooterSwiftSDK
```
* Get the Controller class reference
```swift
var controller = AromaShooterController.sharedInstance
```

### Connect/disconnect devices
We have done the connection UI part for you. You can easily open the connection view controller by one of two ways.
if you are using `NavigationController`, please use these codes.
```swift
let connectionVC = controller.getConnectionViewController()
if let connectionVC = connectionVC {
  self.navigationController?.pushViewController(connectionVC, animated: true)
}
```
In other cases, you can use the below codes.
```swift
let connectionVC = controller.getConnectionViewController()
if let connectionVC = connectionVC {
  self.present(connectionVC, animated: true, completion: nil)
}
```

### Get connected devices
```swift
let connectedDevices = controller.connectedDevices
```  
### Shoot scents
> **Note:** the internal booster must be enabled for any scent to emit — pass `internalBooster: true` (simple) or `internalBoosterIntensity > 0` (with intensity). If it is off, nothing comes out. The external booster (`externalBoosterIntensity`, formerly "fan") exists on AS3 only.

* Shoot scents of all connected devices  
```swift
controller.shootAllSimple(duration: 3000, internalBooster: true, chambers: [1, 2, 3])
```  
* Shoot scents of specific devices  
```swift
controller.shootSimple(aromaShooters: devices, duration: 3000, internalBooster: true, chambers: [1, 2, 3])
```  
* Shoot scents method for AS2 (AromaShooter 2) devices only
```swift
controller.shootAllWithIntensity(durationInMilli: 1000, internalBoosterIntensity: 50, externalBoosterIntensity: 50, chambers: [AromaChamber(number: 3, concentration: 100)])

controller.shootWithIntensity(aromaShooters: controller.connectedDevices, durationInMilli: 1000, internalBoosterIntensity: 50, externalBoosterIntensity: 40, chambers: [AromaChamber(number: 3, concentration: 100)])
``` 

### Stop shooting
Stop all chambers of current connected devices if they have been shooting 
```swift
controller.stopAllSimple();
```

**For more information, please checkout this repository and refer to the [sample project](https://github.com/aromajoin/aromashooter-sdk-ios/tree/master/sample).**  
**If you get any issues or require any new features, please create a [new issue](https://github.com/aromajoin/aromashooter-sdk-ios/issues).** 

## License
Please check the [LICENSE](/LICENSE.md) file for the details.
