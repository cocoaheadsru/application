//
//  UserPO+Requests.swift
//  CHMeetupApp
//
//  Created by Sam on 28/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

extension UserPO {

  typealias RequestsEnum = Requests
  struct Requests {
    // Users list
    static var list: Request<UserPO> {
      return Request(query: "users")
    }

    // Authorization by social network
    static func auth(token: String, socialId: String) -> Request<UserPO> {
      return Request<UserPO>(query: "users", method: .post)
    }

  }
}
