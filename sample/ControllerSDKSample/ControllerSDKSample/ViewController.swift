//
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import UIKit
import AromaShooterControllerSwift

class ViewController: UIViewController {
  let aromaShooterController = AromaShooterController.sharedInstance
  
  @IBAction func diffuseAroma(_ sender: UIButton) {
    aromaShooterController.diffuseAll(duration: 2000, booster: true, ports: [sender.tag])
  }
  
  @IBAction func stopDiffusing(_ sender: UIButton) {
    aromaShooterController.stopAll()
  }
}

