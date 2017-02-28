//
//  TabBarViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
  let remoteService: Remote = RemoteService()
  override func viewDidLoad() {
    super.viewDidLoad()

    // Query example
    do {
      try self.remoteService.load(resourse: UserPO.list) { users in
        guard let users = users else { return }
        for user in users {
          print(user.name)
          print(user.remoteID)
        }
      }
    } catch {
      print("Remote loading error: \(error) for resourse: \(UserPO.list)")
    }

  }

}
