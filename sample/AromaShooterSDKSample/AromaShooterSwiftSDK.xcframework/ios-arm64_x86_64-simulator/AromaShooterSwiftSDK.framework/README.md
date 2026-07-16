# Aroma Shooter SDK (iOS)

**Version 2.0.0**

This is iOS version of Controller SDK written by Swift. 
Protocol document can be found on [Confluence](https://aromashooter.atlassian.net/wiki/spaces/AJ/pages/14254163/Bluetooth+BLE+Protocol).
The prebuilt `AromaShooterSwiftSDK.xcframework`, sample, and documentation are distributed on a separate [Github repository](https://github.com/aromajoin/aromashooter-sdk-ios).

## Requirements
* Minimum iOS deployment target: **iOS 12.0**
* Swift 5.0+ / Xcode 12+ (builds on Xcode 26)

## Installation  
* Add this framework as sub-project: 
    - Clone first: `git clone https://github.com/aromajoin/aromashooter-sdk-ios_secret.git`
    - Go to your project in Xcode, right-click on the root of project => Click "Add Files to ...".
    - In the file chooser, navigate to and select **AromaShooterSwiftSDK.xcodeproj** from the just cloned repository.
* Embed the framework: select the top-level node of your project, click the target, go to the **General** tab, and under **Frameworks, Libraries, and Embedded Content** add the `AromaShooterSwiftSDK` framework as **Embed & Sign**.
* Use cocoaPods: Not suppported yet.  
 
 ## Usage
 
 ## AromaShooter Device. These Methods work with both AS1 and AS2
 
 ### Get Controller references
 * Import Controller module
 ```swift
 import AromaShooterSwiftSDK
 ```
 * Get the Controller class reference
 ```swift
 var controller = AromaShooterController.sharedInstance
 ```
 
 ### Connect/Disconnect devices  
 We have done the connection UI part for you. You can open the connection view controller by one of two ways.
 if you are using `NavigationController`, please use these codes.
 ```swift
 let connectionVC = aromaShooterController.getConnectionViewController()
 if let connectionVC = connectionVC {
   self.navigationController?.pushViewController(connectionVC, animated: true)
 }
 ```
 In other cases, you can use the below codes.
 ```swift
 let connectionVC = aromaShooterController.getConnectionViewController()
 if let connectionVC = connectionVC {
   self.present(connectionVC, animated: true, completion: nil)
 }
 ```

 ### Get connected devices
 ```swift
 let connectedDevices = controller.connectedDevices
 ```  
 > **Note:** The internal booster must be enabled for any scent to emit — pass `internalBooster: true` (simple) or `internalBoosterIntensity > 0` (with intensity). If it is off, nothing comes out. The external booster (`externalBoosterIntensity`, formerly "fan") exists on AS3 only.

 ### Shoot scents
 * Shoot scents of all connected devices  
 ```swift
 controller.shootAllSimple(duration: 3000, internalBooster: true, chambers: [1, 2, 3])
 ```  
 * Shoot scents of specific devices  
 ```swift
 controller.shootSimple(aromaShooters: devices, duration: 3000, internalBooster: true, chambers: [1, 2, 3])
 ```  
 
 ### Stop shooting
 ```swift
 controller.stopAllSimple()
 ```
 
 ## AS2 AromaShooter Device. These Methods only work with AS2
 
 ### Shoot scents. 
 * Shoot scents of all connected devices  
 ```swift
 controller.shootAllWithIntensity(durationInMilli: 1000, internalBoosterIntensity: 50, externalBoosterIntensity: 50, chambers: [AromaChamber(number: 3, concentration: 100)])
 ```  
 * Shoot scents of specific devices  
 ```swift
 controller.shootWithIntensity(aromaShooters: controller.connectedDevices, durationInMilli: 1000, internalBoosterIntensity: 50, externalBoosterIntensity: 0, chambers: [AromaChamber(number: 3, concentration: 100)])
 ```  
 
 ### Stop shooting (AS2)
 ```swift
 controller.stopAllWithIntensity()
 ```
 
 ## License
 Copyright (c) 2017-present Aromajoin Corporation
