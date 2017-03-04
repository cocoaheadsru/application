//
//  PlaceEntity.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 04/03/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation
import RealmSwift

class PlaceEntity: Object {
  dynamic var placeId: Int = 0

  dynamic var title: String = ""

  dynamic var address: String = ""
  dynamic var city: String = ""

  dynamic var latitude: Float = 0
  dynamic var longitude: Float = 0

  override static func primaryKey() -> String? {
    return "placeId"
  }
}
