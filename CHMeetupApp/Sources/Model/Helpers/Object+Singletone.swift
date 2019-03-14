//
//  Object+Singletone.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 04/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

protocol ObjectSingletone: class {
}

extension ObjectSingletone where Self: Object {
  static var value: Self {
    let object = mainRealm.objects(Self.self).first
    if let value = object {
      return value
    } else {
      let value = Self()

      mainRealm.realmWrite {
        mainRealm.add(value)
      }

      return value
    }
  }
}
