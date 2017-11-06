//
//  ImportingStateEntity.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 02/05/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

class ImportingStateEntity: Object {
  @objc dynamic var eventId: Int = 0
  @objc dynamic var calendarIdentifier: String?
  @objc dynamic var reminderIdentifier: String?

  override static func primaryKey() -> String? {
    return "eventId"
  }
}

extension ImportingStateEntity {

  static func createOrGet(for id: Int) -> ImportingStateEntity {
    if let value = mainRealm.objects(ImportingStateEntity.self).first(where: { $0.eventId == id }) {
      return value
    } else {
      let value = ImportingStateEntity()
      value.eventId = id
      realmWrite {
        mainRealm.add(value)
      }
      return value
    }
  }
}
