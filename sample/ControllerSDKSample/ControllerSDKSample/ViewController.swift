//
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import UIKit
import AromaShooterControllerSwift

class ViewController: UIViewController {
  let aromaShooterController = AromaShooterController.sharedInstance

  var intensities: [Int] = [0, 0, 0, 0, 0, 0]

  var durationInMiliSec: Int = 0

  @IBAction func diffuseAroma(_ sender: UIButton) {
    // Work with both AS1 and AS2
    aromaShooterController.diffuseAll(duration: durationInMiliSec, booster: true, ports: [sender.tag])

    // Work only with AS2
    aromaShooterController.diffuseAll(durationInMilli: durationInMiliSec, boosterIntensity: 0, fanIntensity: 0, ports: [CartridgePort(number: sender.tag, intensityPercent: intensities[sender.tag-1])])
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

