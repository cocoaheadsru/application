//
//  SpeechContentEntity.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 04/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

class SpeechContentEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""

  @objc dynamic var linkURL: String = ""
  @objc dynamic var type: String = SpeechContentPlainObject.SpeechContentType.unknown.rawValue

  var typeValue: SpeechContentPlainObject.SpeechContentType {
    get {
      return SpeechContentPlainObject.SpeechContentType(rawValue: type) ?? .unknown
    }
    set {
      type = newValue.rawValue
    }
  }

  override static func primaryKey() -> String? {
    return "id"
  }
}

extension SpeechContentEntity {
  static var templateEntity: SpeechContentEntity {

    let entity = SpeechContentEntity()
    entity.title = "UIViewController, откройся!"
    entity.linkURL = "https://youtu.be/4FNyV_4my1U"
    entity.typeValue = .video
    return entity
  }
}
