//
//  UserPO.swift
//  CHMeetupApp
//
//  Created by Sam on 25/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

struct UserPO {
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

  // FIXME: Move queries consts of here
  static let list = Resource<[UserPO]>(url: Constants.apiBase!, query: "users", params: nil) { json in
    guard let js = json as? [JSONDictionary] else { return nil }
    return js.flatMap(UserPO.init)
  }
}
