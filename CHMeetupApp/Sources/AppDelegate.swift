//
//  AppDelegate.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 20/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    RealmController.shared.setup()
    AppearanceController.setupAppearance()

    // Seems that is most optimal way now to swizzle, without adding Obj-c code into project
    SwizzlingController.swizzleMethods()

    UNUserNotificationCenter.current().delegate = self
    if PermissionsManager.isAllowed(type: .notifications) {
      PushNotificationController.configureNotification()
    }
    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    NotificationCenter.default.post(name: .CloseSafariViewControllerNotification, object: url)
    return true
  }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert])
  }
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()

    PushNotificationController.getAction(from: response, on: self.window)
    completionHandler()
  }
}
