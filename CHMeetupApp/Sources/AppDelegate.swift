//
//  AppDelegate.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 20/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    RealmController.shared.setup()
    AppearanceController.setupAppearance()

    // Seems that is most optimal way now to swizzle, without adding Obj-c code into project
    SwizzlingController.swizzleMethods()

    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    NotificationCenter.default.post(name: .CloseSafariViewControllerNotification, object: url)
    return true
  }

}
