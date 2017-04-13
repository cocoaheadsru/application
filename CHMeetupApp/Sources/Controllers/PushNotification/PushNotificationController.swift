//
//  PushNotificationController.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 13/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import UserNotifications

class PushNotificationController {

  static func configureNotification() {
    UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {_ in
      configureCategories()
      configureSchedule()
    })
  }

  private static func configureCategories() {

    let viewEventAction = UNNotificationAction(identifier: "VIEW_EVENT_ACTION", title: "Описание".localized,
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

  // FIXME: delete it when implement APNs
  private static func configureSchedule() {
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

  static let modelCollection: DataModelCollection<EventEntity> = {
    let predicate = NSPredicate(format: "endDate > %@", NSDate())
    let modelCollection = DataModelCollection(type: EventEntity.self).filtered(predicate)
    return modelCollection
  }()

  static func getAction(from responce: UNNotificationResponse, on window: UIWindow?) {
    if responce.actionIdentifier == "VIEW_EVENT_ACTION" {

      let rootViewController = Storyboards.Main.instantiateInitialViewController()
      window?.rootViewController = rootViewController
      rootViewController.hidesBottomBarWhenPushed = true

      // swiftlint:disable force_cast
      let navigationController = rootViewController.viewControllers?.first as! NavigationViewController

      let eventPreview = Storyboards.EventPreview.instantiateEventPreviewViewController()
      eventPreview.selectedEventId = modelCollection[0].id

      navigationController.viewControllers.append(eventPreview)
    } else if responce.actionIdentifier == "REGISTER_ACTION" {
    }
  }
}
