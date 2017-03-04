//
//  UserEntity.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 04/03/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation
import RealmSwift

class UserEntity: Object {
  dynamic var userId: Int = 0

  dynamic var name: String = ""
  dynamic var lastName: String = ""

  dynamic var company: String = ""
  dynamic var position: String = ""

  dynamic var info: String = ""

  dynamic var phone: String = ""
  dynamic var email: String = ""

  dynamic var isSpeaker: Bool = false
  dynamic var photoURL: String = ""

  let speaches = List<SpeechEntity>()
  let socials = List<SocialEntity>()

  override static func primaryKey() -> String? {
    return "userId"
  }
}
