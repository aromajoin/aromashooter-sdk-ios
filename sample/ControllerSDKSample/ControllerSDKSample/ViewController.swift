//
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import UIKit
import AromaShooterControllerSwift

class ViewController: UIViewController {
  let aromaShooterController = AromaShooterController.sharedInstance
  
  @IBAction func diffuseAroma(_ sender: UIButton) {
    // Work with both AS1 and AS2
    aromaShooterController.diffuseAll(duration: 2000, booster: true, ports: [sender.tag])
    
    // Work only with AS2
    aromaShooterController.diffuseAll(durationInMilli: 2000, boosterIntensity: 0, fanIntensity: 0, ports: [CartridgePort(number: sender.tag, intensityPercent: 80)])
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
}

