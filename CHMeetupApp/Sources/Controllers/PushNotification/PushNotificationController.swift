//
//  PushNotificationController.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 13/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UserNotifications

class PushNotificationController {
  static func configureNotification() {
    UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { settings in
      configureCategories()
      configureSchedule()
    })
  }

  static func configureCategories() {
    let viewEventAction = UNNotificationAction(identifier: "VIEW_EVENT", title: "Описание".localized,
                                               options: .foreground)
    let registerAction = UNNotificationAction(identifier: "REGISTER_ACTION", title: "Зарегестрироваться".localized,
                                              options: .foreground)

    let newEventCategory = UNNotificationCategory(identifier: "NEW_EVENT", actions: [ viewEventAction, registerAction],
                                                  intentIdentifiers: [], options: .customDismissAction)
    let registationConfirmed = UNNotificationCategory(identifier: "REGISTRATION_CONFIRMED",
                                                      actions: [viewEventAction],
                                                      intentIdentifiers: [], options: .customDismissAction)

    UNUserNotificationCenter.current().setNotificationCategories([newEventCategory, registationConfirmed])
  }

  static func configureSchedule() {
    let notificationContent = UNMutableNotificationContent()
    notificationContent.title = "Скоро новое событие!".localized
    notificationContent.body = "12 мая пройдет очередная встреча CocoaHeads в питерском офисе Яндекса!".localized
    notificationContent.categoryIdentifier = "NEW_EVENT"

    let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)

    let notificationRequest = UNNotificationRequest(identifier: "NEW_EVENT_NOTIFICATION",
                                                    content: notificationContent, trigger: notificationTrigger)

    UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: { error in
      if let error = error {
        print("Error when add notification request: \(error)")
      }
    })
  }
}
