//
//  TranslateEventPlainObject.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 19/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

struct EventPlainObjectTranslation: PlainObjectTranslation {
  static func addToRealm(plainObject: EventPlainObject) {
    let event = EventEntity()
    event.id = plainObject.id
    event.title = plainObject.title
    event.startDate = plainObject.startDate
    event.endDate = plainObject.endDate
    event.descriptionText = plainObject.description

    let place = PlaceEntity()
    place.id = plainObject.place.placeID
    place.title = plainObject.place.title
    place.address = plainObject.place.address
    place.latitude = plainObject.place.latitude
    place.longitude = plainObject.place.longitude
    event.place = place

    realmWrite {
      mainRealm.add(event, update: true)
      mainRealm.add(place, update: true)
    }
  }
}
