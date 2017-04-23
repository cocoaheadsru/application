//
//  CreatorsController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 23/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

class CreatorsController {
  static func loadList(completion: @escaping (_ users: CreatorsViewDisplayCollection?, _ error: ServerError?) -> Void) {
    Server.standard.request(UserPlainObject.Requests.listOfCreators) { users, error in

      guard error == nil, let users = users else {
        DispatchQueue.main.async {
          completion(nil, error)
        }
        return
      }

      let displayCollection = CreatorsViewDisplayCollection(with: users)
      DispatchQueue.main.async {
        completion(displayCollection, nil)
      }
    }
  }
}
