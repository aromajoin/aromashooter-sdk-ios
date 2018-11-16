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
 
 ### Get Controller references
 * Import Controller module
 ```swift
 import AromaShooterControlerSwift
 ```
 * Get the Controller class reference
 ```swift
 var controller = AromaShooterController.sharedInstance
 ```
 
 ### Connect devices  
 There are 2 options.
 * Use the existing connection screen (ConnectionViewController) inside `sample` app. This is easy and recommended. 
 * Please check out this repository, grab `ConnectionViewController.swift` file to put in your project. 
 * For further detail, please take a look our `sample` applicaton.  
 * Write your own connection screen using our API.
 * Scan AromaShooter devices
 ```swift
 controller.startScanning()
 ```  
 * Make sure that scanning is stopped when the view controller dissapear
 ```swift
 override func viewWillDisappear(_ animated: Bool) {
 // Stop searching
 controller.stopScanning()
 }
 ```  
 * Connect
 ```swift
 controller.connect(aromaShooters: devices)
 ```  
 * Disconnect
 ```swift
 controller.disconnect(aromaShooter: device)
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
 
 ## License
 Copyright (c) 2017-present Aromajoin Corporation
