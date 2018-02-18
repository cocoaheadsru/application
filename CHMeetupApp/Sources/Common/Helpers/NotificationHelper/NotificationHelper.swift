//
//  NotificationController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 19/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class NotificationHelper {
  static func viewController(title: String? = nil,
                             description: String? = nil,
                             emoji: String? = nil,
                             completion: @escaping ActionCompletionBlock = {}) -> NotificationViewController {
    let notification = Storyboards.Main.instantiateNotificationViewController()
    notification.titleText = title
    notification.descriptionText = description
    notification.completionBlock = completion
    notification.emoji = emoji
    notification.modalPresentationStyle = .overFullScreen

    return notification
  }
}
