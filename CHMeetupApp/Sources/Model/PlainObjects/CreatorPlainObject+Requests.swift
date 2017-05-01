//
//  CreatorPlainObject+Requests.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 01/05/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

extension CreatorPlainObject: PlainObjectType {

  struct Requests {
    // Creators list

    static var list: Request<[CreatorPlainObject]> {
      return Request<[CreatorPlainObject]>(query: "users/creators")
    }
  }
}

extension CreatorPlainObject {

  init?(json: JSONDictionary) {
    guard
      let id = json["id"] as? Int,
      let name = json["name"] as? String
      else { return nil }

    self.id = id
    self.name = name
    photoUrl = json["photo_url"] as? String
    url = json["url"] as? String
    info = json["info"] as? String
  }
}
