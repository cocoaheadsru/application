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
                      completion block: @escaping (Void) -> (Void)) {
    let notification = Storyboards.Main.instantiateNotificationViewController()
    notification.titleLabel.text = title
    notification.textLabel.text = text
    notification.completionBlock = block
    viewController.present(notification, animated: true, completion: nil)
  }
}
