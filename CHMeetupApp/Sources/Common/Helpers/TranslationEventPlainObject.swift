//
//  TranslateEventPlainObject.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 19/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

class TranslationEventPlainObject: TranslationPlainObject {

  static func translate(of plainObjects: [PlainObjectType]) {
    _ = plainObjects.map(addToRealm)
  }

  static func addToRealm(plainObject: PlainObjectType) {
    guard let pastEvent = plainObject as? EventPlainObject else {
      return
    }
    let event = EventEntity()
    event.id = pastEvent.id
    event.title = pastEvent.title
    event.startDate = pastEvent.startDate
    event.endDate = pastEvent.endDate
    event.photoURL = pastEvent.photoUrl
    event.descriptionText = pastEvent.description

    let place = PlaceEntity()
    place.id = pastEvent.place.placeID
    place.title = pastEvent.place.title
    place.address = pastEvent.place.address
    place.latitude = pastEvent.place.latitude
    place.longitude = pastEvent.place.longitude
    event.place = place

    realmWrite {
      mainRealm.add(event, update: true)
      mainRealm.add(place, update: true)
    }
  }
}
