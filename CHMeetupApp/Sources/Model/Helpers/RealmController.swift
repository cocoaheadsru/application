//
//  RealmController.swift
//
//  Created by Igor Tudoran on 07.02.17.
//

import Foundation
import RealmSwift

var mainRealm: Realm!

class RealmController {

  static var shared: RealmController = RealmController()

  let schemaVersion: UInt64 = 25

  func setup() {
    Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: nil)

    do {
      mainRealm = try Realm()
      EventEntity.resetEntitiesStatus()
      NearestUserEntity.resetDiscoveredStatus()

    } catch let error as NSError {
      NotificationCenter.default.post(name: .RealmLoadingErrorNotifications,
                                      object: nil)
      assertionFailure("Realm loading error: \(error)")
    }
  }
}
