//
//  UserPO.swift
//  CHMeetupApp
//
//  Created by Sam on 25/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation
typealias JSONDictionary = [String: Any]

struct UserPO4 {
  let remoteID: Int
  let name: String

  init?(json: JSONDictionary) {
    guard
      let id = json["id"] as? Int,
      let name = json["username"] as? String
    else { return nil }

    self.remoteID = id
    self.name = name
  }
}
