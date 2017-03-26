//
//  TabBarViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class TabBarViewController: CustomTabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Query example

    Server.standard.request(SpeechPlainObject.Requests.speechesOnEvent(with: 1)) { speeches, error in
      if let error = error {
        print(error)
      }

      for speech in speeches ?? [] {
        print(speech)
      }
    }

    Server.standard.request(UserPlainObject.Requests.listOfIds) { users, error in
      if let error = error {
        print(error)
      }

      for user in users ?? [] {
        print(user)
      }
    }
  }
}
