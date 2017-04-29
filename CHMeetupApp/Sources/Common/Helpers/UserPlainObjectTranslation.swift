//
//  UserPlainObjectTranslation.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 29/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct UserPlainObjectTranslation: PlainObjectTranslation {
  static func addToRealm(plainObject: UserPlainObject, to parent: UserEntity? = nil) {
    assert(parent != nil, "Parent should exist")

    let user = UserEntity()
    user.id = plainObject.id
    user.name = plainObject.name
    user.lastName = plainObject.lastname
    user.photoURL = plainObject.photoUrl
    user.company = plainObject.company

    realmWrite {
      mainRealm.add(user, update: true)
    }
  }
}
