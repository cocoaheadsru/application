//
//  NearestUserEntity.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 16/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

final class NearestUserEntity: TemplatableObject, TemplateEntity {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var deviceUUID: String = ""
  @objc dynamic var discovered: Bool = false

  override static func primaryKey() -> String? {
    return "id"
  }

  static func resetDiscoveredStatus() {
    realmWrite {
      for user in mainRealm.objects(NearestUserEntity.self).filter("discovered == true") {
        user.discovered = false
      }
    }
  }

}

extension NearestUserEntity {
  static var templateEntity: NearestUserEntity {
    let names = ["Ivan", "Petr", "Anton"]

    let entity = NearestUserEntity()
    entity.name <= names.rand
    return entity
  }
}
