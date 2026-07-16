//
//  Copyright © 2017-present Aromajoin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // UI is built entirely in code — no Main.storyboard.
    let window = UIWindow(frame: UIScreen.main.bounds)
    let nav = UINavigationController(rootViewController: ViewController())
    if #available(iOS 13.0, *) {
      nav.navigationBar.prefersLargeTitles = true
    }
    window.rootViewController = nav
    window.makeKeyAndVisible()
    self.window = window
    return true
  }
}
