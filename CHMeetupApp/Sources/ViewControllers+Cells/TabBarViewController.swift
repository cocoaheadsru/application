//
//  TabBarViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

  var collection: DataModelCollection<UserPlainObject>!

  override func viewDidLoad() {
    super.viewDidLoad()

    collection = DataModelCollection(type: UserPlainObject.self)
    collection = collection.sorted(byKeyPath: "name")

//    let value = collection.objectAtIndex(index: 2)

    // Query example
    Server.request(UserPlainObject.Requests.list) { (users, error) in
      if let error = error {
        print(error)
      }

      for user in users ?? [] {
        print(user)
      }
    }

    Server.request(UserPlainObject.Requests.auth(token: "", socialId: "")) { (user, error) in
      if let error = error {
        print(error)
      }

      print(user ?? "Nil user")
    }

    Server.request(UserPlainObject.Requests.listOfIds) { (users, error) in
      if let error = error {
        print(error)
      }

      for user in users ?? [] {
        print(user)
      }
    }
  }
}
