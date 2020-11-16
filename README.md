[English](https://github.com/aromajoin/controller-sdk-ios) / [日本語](README-JP.md)

# Controller SDK for iOS

[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg?style=flat-square)](https://www.apache.org/licenses/LICENSE-2.0.html) 
[![Join the community on Spectrum](https://withspectrum.github.io/badge/badge.svg)](https://spectrum.chat/aromajoin-software/)


**The iOS version of AromaShooterController SDK which is used to communicate with [Aroma Shooter devices](https://aromajoin.com/products/aroma-shooter)**.

# Table of Contents
1. [Supported devices](#supported-devices)  
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Usage](#usage)
    * [Connect/Disconnect devices](#connectdisconnect-devices)
    * [Get connected devices](#get-connected-devices)
    * [Diffuse scents](#diffuse-scents)
    * [Stop diffusing](#stop)
5. [License](#license)

## Supported devices
* Aroma Shooter Bluetooth version 

## Prerequisites
* iOS version: >= 8.0
* Swift version: >= 3.0

## Installation  
* Download the [framework file at the release page](https://github.com/aromajoin/controller-sdk-ios/releases).  
* Drag and drop it into your project. (Make sure that it is added in *Embedded Binaries section* in your project's target page).

Watch a [video walkthrough](https://youtu.be/MepAhofA9PE) of this process to simplify your life.

## Usage

### Add Bluetooth usage description to `Info.plist` file
From iOS 13 and later, it is required to add the Bluetooth usage description, if not the app will be crashed.
So, please add the key and its value to the app's `Info.plist` file.
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>The app uses Bluetooth to connect to Aroma Shooter</string>
```

### Get Controller references
* Import Controller module
```swift
import AromaShooterControllerSwift
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
### Diffuse scents
* Diffuse scents of all connected devices  
```swift
controller.diffuseAll(duration: 3000, booster: true, ports: [1, 2, 3])
```  
* Diffuse scents of specific devices  
```swift
controller.diffuse(aromaShooters: devices, duration: 3000, booster: true, port: [1, 2, 3])
```  
* Diffuse scents method for AS2 (AromaShooter 2) devices only
```swift
controller.diffuseAll(durationInMilli: 1000, boosterIntensity: 0, fanIntensity: 50, ports: [CartridgePort(number: 3, intensityPercent: 100)])

controller.diffuse(aromaShooters: controller.connectedDevices, durationInMilli: 1000, boosterIntensity: 50, fanIntensity: 40, ports: [CartridgePort(number: 3, intensityPercent: 100)])
``` 

### Stop diffusing
Stop all ports of current connected devices if they have been diffusing 
```swift
controller.stopAll();
```

**For more information, please checkout this repository and refer to the [sample project](https://github.com/aromajoin/controller-sdk-ios/tree/master/sample).**  
**If you get any issues or require any new features, please create a [new issue](https://github.com/aromajoin/controller-sdk-ios/issues).** 

## License
Please check the [LICENSE](/LICENSE.md) file for the details.
