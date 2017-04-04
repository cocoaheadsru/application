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

  dynamic var linkURL: String = ""
  dynamic var type: String = ""

  override static func primaryKey() -> String? {
    return "id"
  }
}
