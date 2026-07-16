//
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import UIKit
import AromaShooterSwiftSDK

class ViewController: UIViewController {
  let aromaShooterController = AromaShooterController.sharedInstance

  var concentrations: [Int] = [100, 100, 100, 100, 100, 100]

  var durationInMiliSec: Int = 3000

  @IBAction func diffuseAroma(_ sender: UIButton) {
    let cartridgeNumber = sender.tag
    // Work only with AS2
    // Note: internalBooster must be > 0, otherwise no scent is emitted.
    aromaShooterController.shootAllWithIntensity(durationInMilli: durationInMiliSec, internalBoosterIntensity: 100, externalBoosterIntensity: 100, chambers: [AromaChamber(number: cartridgeNumber, concentration: concentrations[cartridgeNumber - 1])])

    // If you want to work with our older version of Aroma Shooter
    // Please uncomment the code below

    // aromaShooterController.shootAllSimple(duration: durationInMiliSec, internalBooster: true, chambers: [sender.tag])
  }

  @IBAction func stopDiffusing(_ sender: UIButton) {
    aromaShooterController.stopAllSimple()
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
    concentrations[sender.tag - 1] = Int(sender.value)
  }
}
