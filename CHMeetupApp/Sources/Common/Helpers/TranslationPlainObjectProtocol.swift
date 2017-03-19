//
//  TranslationPlainObjectProtocol.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 19/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

protocol TranslationPlainObject {
  static func translate(of plainObjects: [PlainObjectType])
  static func addToRealm(plainObject: PlainObjectType)
}
