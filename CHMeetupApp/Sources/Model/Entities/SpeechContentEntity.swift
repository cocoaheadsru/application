//
//  SpeechContentEntity.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 04/03/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation
import RealmSwift

class SpeechContentEntity: Object {
  dynamic var contentId: Int = 0

  dynamic var title: String = ""
  dynamic var descriptionText: String = ""

  dynamic var linkURL: String = ""
  dynamic var type: Int = 0

  private let speeches = LinkingObjects(fromType: SpeechEntity.self, property: "contents")

  var speech: SpeechEntity? {
    return speeches.first
  }

  override static func primaryKey() -> String? {
    return "contentId"
  }
}
