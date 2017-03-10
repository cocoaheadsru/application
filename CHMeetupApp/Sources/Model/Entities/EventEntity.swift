//
//  EventEntity.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 04/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

class EventEntity: Object {
  dynamic var id: Int = 0

  dynamic var title: String = ""
  dynamic var descriptionText: String = ""

  dynamic var startDate: Date = Date()
  dynamic var endDate: Date = Date()

  dynamic var photoURL: String = ""

  dynamic var place: PlaceEntity?

  let speeches = List<SpeechEntity>()

  override static func primaryKey() -> String? {
    return "id"
  }
}
