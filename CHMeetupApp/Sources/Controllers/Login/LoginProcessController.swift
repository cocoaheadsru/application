//
//  LoginProcessViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

private let loginName = "UD.key.isLogin"

class LoginProcessController {

  static var isLogin: Bool {
    set {
      realmWrite {
        UserPreferencesEntity.value.isLoggedIn = newValue
      }
    }
    get {
      return UserPreferencesEntity.value.isLoggedIn
    }
  }
}

extension Notification.Name {
  static let CloseSafariViewControllerNotification: Notification.Name =
    Notification.Name(rawValue: "CloseSafariViewControllerNotification")
}
