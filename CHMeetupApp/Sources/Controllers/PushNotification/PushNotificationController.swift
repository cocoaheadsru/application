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

  private enum Categories: String {
      case newEventCategory = "NEW_EVENT"
      case confirmedCategory = "REGISTRATION_CONFIRMED"
    }

  private enum Actions: String {
    case viewEventAction = "VIEW_EVENT_ACTION"
    case registerAction = "REGISTER_EVENT_ACTION"
  }

  static func configureNotification() {
    UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { _ in
      configureCategories()
      configureSchedule()
    })
  }

  private static func configureCategories() {

    let viewEventAction = UNNotificationAction(identifier: Actions.viewEventAction.rawValue,
                                               title: "Описание встречи".localized,
                                               options: .foreground)
    let registerToEventAction = UNNotificationAction(identifier: Actions.registerAction.rawValue,
                                                     title: "Зарегистрироваться".localized,
                                              options: .foreground)

    let newEventCategory = UNNotificationCategory(identifier: Categories.newEventCategory.rawValue,
                                                  actions: [ viewEventAction, registerToEventAction],
                                                  intentIdentifiers: [], options: .customDismissAction)
    let registationConfirmedCategory = UNNotificationCategory(identifier: Categories.confirmedCategory.rawValue,
                                                      actions: [viewEventAction],
                                                      intentIdentifiers: [], options: .customDismissAction)

    UNUserNotificationCenter.current().setNotificationCategories([newEventCategory, registationConfirmedCategory])
  }

  // FIXME: delete it when implement APNs
  private static func configureSchedule() {
    let newEventNotificationContent = UNMutableNotificationContent()
    newEventNotificationContent.title = "Скоро новое событие!".localized
    newEventNotificationContent.body = "12 мая пройдет очередная встреча CocoaHeads в питерском офисе Яндекса".localized
    newEventNotificationContent.categoryIdentifier = Categories.newEventCategory.rawValue

    // Push will receive after 10 seconds
    let newEventNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

    let newEventNotificationRequest = UNNotificationRequest(identifier: "NEW_EVENT_NOTIFICATION",
                                                    content: newEventNotificationContent,
                                                    trigger: newEventNotificationTrigger)

    let confirmedNotificationContent = UNMutableNotificationContent()
    confirmedNotificationContent.title = "Поздравляем!".localized
    confirmedNotificationContent.body = "Ваша заявка на встречу 12 мая принята!".localized
    confirmedNotificationContent.categoryIdentifier = Categories.confirmedCategory.rawValue

    // Push will receive after 20 seconds
    let confirmedNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)

    let confirmedNotificationRequest = UNNotificationRequest(identifier: "CONFIRMED_NOTIFICATION",
                                                             content: confirmedNotificationContent,
                                                             trigger: confirmedNotificationTrigger)
    UNUserNotificationCenter.current().add(newEventNotificationRequest, withCompletionHandler: { error in
      if let error = error {
        print("Error when add notification request: \(error)")
      }
    })
    UNUserNotificationCenter.current().add(confirmedNotificationRequest, withCompletionHandler: { error in
      if let error = error {
        print("Error when add notification request: \(error)")
      }
    })
  }

  static func getAction(from response: UNNotificationResponse, on window: UIWindow?) {
    let rootViewController = Storyboards.Main.instantiateInitialViewController()
    window?.rootViewController = rootViewController
    guard let navigationController = rootViewController.viewControllers?.first as? NavigationViewController else {
      assertionFailure("No navigation controller")
      return
    }

    guard let action = Actions(rawValue: response.actionIdentifier) else {
      assertionFailure("No such action")
      return
    }

    let eventPreviewController = Storyboards.EventPreview.instantiateEventPreviewViewController()
    // FIXME: - Replace with real id
    eventPreviewController.selectedEventId = 5
    switch action {
    case .viewEventAction:
      navigationController.viewControllers.append(eventPreviewController)
    case .registerAction:
      navigationController.viewControllers.append(eventPreviewController)
      // FIXME: - Replace with real id
      let viewController = ViewControllersFactory.eventRegistrationOrAuthViewController(
        eventId: 0
      )
      eventPreviewController.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}
