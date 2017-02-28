//
//  TabBarViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Query example

    Server.request(UserPO.Requests.list) { (users) in
      for user in users! {
        print(user)
      }
    }
    
  }
}
