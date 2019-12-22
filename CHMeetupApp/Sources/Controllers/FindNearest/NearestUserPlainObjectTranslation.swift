//
//  NearestUserPlainObjectTranslation.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 16/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

struct NearestUserPlainObjectTranslation: PlainObjectTranslation {
  /*
  static func translate(of plainObjects: [Value], to parent: Parent?) {
    NearestUserEntity.resetDiscoveredStatus()
    plainObjects.forEach({
      addToRealm(plainObject: $0, to: parent)
    })
  }
  */
  static func addToRealm(plainObject: Beacon, to parent: NearestUserEntity? = nil) {
    let nearestUser = NearestUserEntity()
    nearestUser.id = plainObject.userInfo?.id ?? 0
    nearestUser.name = plainObject.userInfo?.name ?? ""
    nearestUser.photoURL = plainObject.userInfo?.photoURL
    nearestUser.deviceUUID = plainObject.proximityUUID.uuidString
    nearestUser.discovered = plainObject.discovered

    realmWrite {
      mainRealm.add(nearestUser, update: true)
    }
  }

}
