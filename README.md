[English](https://github.com/aromajoin/controller-sdk-ios) / [日本語](README-JP.md)

# Controller SDK for iOS

[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg?style=flat-square)](https://www.apache.org/licenses/LICENSE-2.0.html)

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

## Usage

### Get Controller references
* Import Controller module
```swift
import AromaShooterControlerSwift
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
### Stop diffusing
Stop all ports of current connected devices if they have been diffusing 
```swift
controller.stopAll();
```

**For more information, please checkout this repository and refer to the [sample project](https://github.com/aromajoin/controller-sdk-ios/tree/master/sample).**  
**If you get any issues or require any new features, please create a [new issue](https://github.com/aromajoin/controller-sdk-ios/issues).** 

## License

    Copyright (c) 2017 Aromajoin Corporation

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
