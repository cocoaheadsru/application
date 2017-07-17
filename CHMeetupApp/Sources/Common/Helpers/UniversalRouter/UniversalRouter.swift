//
//  UniversalRouter.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 17/07/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

final class UniversalRouter {
  var mainWindow: UIWindow!
  var tabBarController: UITabBarController!

  enum TabbarSection {
    case anonses
    case pastEvents
    case profile
  }

  func activate(section: TabbarSection) {
    self.tabBarController.selectedIndex = section.hashValue
  }

}
