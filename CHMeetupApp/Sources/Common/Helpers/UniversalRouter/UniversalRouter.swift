//
//  UniversalRouter.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 17/07/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

final class UniversalRouter {
  var mainWindow: UIWindow?

  init(with window: UIWindow?) {
    mainWindow = window
  }

  var tabBarController: CHMeetupApp.TabBarViewController? {
    return mainWindow?.rootViewController as? CHMeetupApp.TabBarViewController
  }

  //
  enum TabbarSection {
    case anonses
    case pastEvents
    case profile
  }

  func activate(section: TabbarSection) {
    self.tabBarController?.selectedIndex = section.hashValue
  }

  func updateAnonseStatus(`for` eventId: Int, status: String) {
    let status = EventEntity.EventRegistrationStatus(rawValue: status)
    let anonses = viewController(for: .anonses) as? MainViewController
    anonses?.updateStateFor(event: eventId, status: status ?? .unknown)
  }

  private func viewController(`for` section: TabbarSection) -> UIViewController? {
    let navigationVC = self.tabBarController?.viewControllers?[TabbarSection.anonses.hashValue] as? UINavigationController
    return navigationVC?.viewControllers.first
  }
}
