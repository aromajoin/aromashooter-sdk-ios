//
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import UIKit
import AromaShooterControllerSwift

class ViewController: UIViewController {
  let aromaShooterController = AromaShooterController.sharedInstance

  var intensities: [Int] = [100, 100, 100, 100, 100, 100]

  var durationInMiliSec: Int = 3000

  @IBAction func diffuseAroma(_ sender: UIButton) {
    let cartridgeNumber = sender.tag
    // Work only with AS2
    aromaShooterController.diffuseAll(durationInMilli: durationInMiliSec, boosterIntensity: 100, fanIntensity: 100, ports: [CartridgePort(number: cartridgeNumber, intensityPercent: intensities[cartridgeNumber - 1])])
    
    // If you want to work with our older version of Aroma Shooter
    // Please uncomment the code below
    
    // aromaShooterController.diffuseAll(duration: durationInMiliSec, booster: true, ports: [sender.tag])
  }

  @IBAction func stopDiffusing(_ sender: UIButton) {
    aromaShooterController.stopAll()
  }

  @IBAction func openConnectionScreen(_ sender: Any) {
    let connectionVC = aromaShooterController.getConnectionViewController()
    if let connectionVC = connectionVC {
      self.navigationController?.pushViewController(connectionVC, animated: true)
    }
  }
  
  @IBAction func durationEditor(_ sender: UITextField) {
    guard let duration = Int(sender.text ?? "0") else {
      return
    }

    durationInMiliSec = duration
  }

  @IBAction func intensitySlider(_ sender: UISlider) {
    intensities[sender.tag - 1] = Int(sender.value)
  }
}

