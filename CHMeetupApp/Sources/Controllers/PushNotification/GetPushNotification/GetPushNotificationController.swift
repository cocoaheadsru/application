//
//  GetPushNotificationController.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 17/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UserNotifications
import UIKit

class GetPushNotificationController: NSObject, UNUserNotificationCenterDelegate {
  var windowManager: ActiveWindowManager

  init(with windowManager: ActiveWindowManager) {
    self.windowManager = windowManager
    super.init()
    UNUserNotificationCenter.current().delegate = self
  }

  typealias CompletionHandler = (UNNotificationPresentationOptions) -> Void

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping CompletionHandler) {
    completionHandler([.alert])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    windowManager.window = UIWindow(frame: UIScreen.main.bounds)
    windowManager.window?.makeKeyAndVisible()

    PushNotificationController.getAction(from: response, on: windowManager.window)

    completionHandler()
  }
}
