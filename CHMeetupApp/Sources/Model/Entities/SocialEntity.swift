//
//  SocialEntity.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 04/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

class SocialEntity: Object {
  dynamic var id: Int = 0

  dynamic var name: String = ""
  dynamic var url: String = ""
  dynamic var isPrivate: Bool = true

  private let users = LinkingObjects(fromType: UserEntity.self, property: "socials")

  var user: UserEntity? {
    return users.first
  }

  override static func primaryKey() -> String? {
    return "id"
  }
}
#if DEBUG
extension SocialEntity {
  static var templateEntity: SocialEntity {
    let entity = SocialEntity()
    entity.name = "vk"
    entity.url = "https://vk.com/cocoaheadsrussia?w=wall-119039957_40"
    entity.isPrivate = false
    return entity
  }
}
#endif
