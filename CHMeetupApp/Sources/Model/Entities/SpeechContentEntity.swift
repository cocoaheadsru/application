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
  dynamic var id: Int = 0

  dynamic var title: String = ""
  dynamic var descriptionText: String = ""

  dynamic var linkURL: String = ""
  dynamic var type: String = SpeechContentPlainObject.SpeechContentType.unknown.rawValue

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
    // swiftlint:disable:next line_length
    entity.descriptionText = "Речь пойдёт о презентации UIViewController и о творящейся за кулисами магии: создании собственной анимации перехода и протоколе UIViewControllerAnimatedTransitioning. Докладчик поделится собственными приёмами, помогающими в нестандартных ситуациях — например, если ориентация экрана меняется в самый неподходящий момент."
    entity.linkURL = "https://youtu.be/4FNyV_4my1U"
    entity.typeValue = .video
    return entity
  }
}
