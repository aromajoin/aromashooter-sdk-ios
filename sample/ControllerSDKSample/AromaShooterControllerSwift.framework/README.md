# Aroma Shooter Controller

This is iOS version of Controller SDK written by Swift. 
Protocol document can be found on [Confluence](https://aromashooter.atlassian.net/wiki/spaces/AJ/pages/14254163/Bluetooth+BLE+Protocol).
The binary file, sample, and documentation is distributed on a separate [Github repository](https://github.com/aromajoin/controller-sdk-ios).

## Installation  
* Add this framework as sub-project: 
    - Clone first: git clone git@bitbucket.org:aromajoin/aromashootercontrollerswift.git  
    - Go to your project in Xcode, right-click on the root of project => Click "Add Files to ...".
    - In the file chooser, navigate to and select **AromaShooterController.xcodeproj** from the just cloned repository.
* Add framework to **Embedded Binaries**: Select the top level node of your project, click the target and go to General tab and scroll down to Embedded Binaries section and add AromaShooterControllerSwift framework there.
* Use cocoaPods: Not suppported yet.  
 
 ## Usage
 
 ## AS1 AromaShooter Device. Method from AS1 only work with AS1 AromaShooter Device
 
 ### Get Controller references
 * Import Controller module
 ```swift
 import AromaShooterControlerSwift
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
 ```swift
 constroller.stopAll()
 ```
 
 ## AS2 AromaShooter Device. Note: Method from AS1 can also be use with AS2 AromaShooter device
 
 ### Diffuse scents. 
 * Diffuse scents of all connected devices  
 ```swift
 controller.diffuseAll(durationInMilli: 1000, boosterIntensity: 0, fanIntensity: 50, ports: [CartridgePort(number: 3, intensityPercent: 100)])
 ```  
 * Diffuse scents of specific devices  
 ```swift
 controller.diffuse(aromaShooters: controller.connectedDevices, durationInMilli: 1000, boosterIntensity: 0, fanIntensity: 0, ports: [CartridgePort(number: 3, intensityPercent: 100)])
 ```  
 
 ## License
 Copyright (c) 2017-present Aromajoin Corporation
