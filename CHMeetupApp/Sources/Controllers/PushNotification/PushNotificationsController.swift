//
//  PushNotificationsController.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 13/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import UserNotifications

class PushNotificationsController {
  static func registerNotification(token: Data) {
    let deviceTokenString = token.reduce("", {$0 + String(format: "%02X", $1)})
    registerNotification(tokenString: deviceTokenString)
  }

  static func registerNotification(tokenString: String) {
    let request = RequestPlainObject.Requests.registerPush(pushToken: tokenString,
                                                           userToken: UserPreferencesEntity.value.currentUser?.token)
    Server.standard.request(request) { answer, _ in
      print("Token register: \(answer?.answer ?? "failed")")
    }
  }
}
