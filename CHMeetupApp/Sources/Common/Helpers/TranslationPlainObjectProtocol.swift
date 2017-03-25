//
//  TranslationPlainObjectProtocol.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 19/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

protocol PlainObjectTranslation {
  associatedtype Value = PlainObjectType
  static func translate(of plainObjects: [Value])
  static func addToRealm(plainObject: Value)
}

extension PlainObjectTranslation {
  static func translate(of plainObjects: [Value]) {
    plainObjects.forEach(addToRealm)
  }
}
