//
//  NotificationController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 19/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class NotificationController {
  static func present(from viewController: UIViewController,
                      title: String? = nil,
                      description: String? = nil,
                      emjoi: String? = nil,
                      completion block: @escaping () -> (Void)) {
    let notification = Storyboards.Main.instantiateNotificationViewController()
    notification.titleText = title
    notification.descriptionText = description
    notification.completionBlock = block
    notification.emjoi = emjoi
    notification.modalPresentationStyle = .overFullScreen

    viewController.present(notification, animated: true, completion: nil)
  }
}
