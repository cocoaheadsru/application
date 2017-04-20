//
//  NotificationController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 19/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class NotificationController {
  static func present(to viewController: UIViewController,
                      with title: String? = nil,
                      description text: String? = nil,
                      emoji: String? = nil,
                      completion block: @escaping () -> (Void)) {
    let notification = Storyboards.Main.instantiateNotificationViewController()
    notification.titleText = title
    notification.descriptionText = text
    notification.completionBlock = block
    notification.emoji = emoji
    notification.modalPresentationStyle = .overFullScreen

    viewController.present(notification, animated: true, completion: nil)
  }
}
