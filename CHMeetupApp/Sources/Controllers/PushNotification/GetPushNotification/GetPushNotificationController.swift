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
  static var shared: GetPushNotificationController = GetPushNotificationController()

  weak var appDelegate: AppDelegate?

  func setup(with appDelegate: AppDelegate) {
    UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    self.appDelegate = appDelegate
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
    appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
    appDelegate?.window?.makeKeyAndVisible()

    PushNotificationController.getAction(from: response, on: appDelegate?.window)

    completionHandler()
  }
}
