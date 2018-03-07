//
//  PlaceEntity.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 04/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

class PlaceEntity: Object {
  @objc dynamic var id: Int = 0

  @objc dynamic var title: String = ""

  @objc dynamic var address: String = ""
  @objc dynamic var city: String = ""

  @objc dynamic var latitude: Double = 0
  @objc dynamic var longitude: Double = 0

  override static func primaryKey() -> String? {
    return "id"
  }
}

extension PlaceEntity {
  static var templateEntity: PlaceEntity {

    struct Place {
      let title: String
      let address: String
      let city: String
      let latitude: Double
      let longitude: Double
    }

    let places: [Place] = [
      Place(title: "PromptWorks", address: "1211 Chestnut Street Suite 400",
            city: "Philadelphia", latitude: 39.95, longitude: -75.16),
      Place(title: "The Coffee Room", address: "Kinkerstraat 110",
            city: "Amsterdam", latitude: 52.37, longitude: 4.89),
      Place(title: "Coffee Culture", address: "1525 Dundas St E.",
            city: "Philadelphia", latitude: 54.49, longitude: -0.61),
      Place(title: "Starbucks", address: "21 Kuznetsky Most",
            city: "Moscow", latitude: 55.75, longitude: 37.62)
    ]
    let place = places.rand!

    let entity = PlaceEntity()
    entity.title = place.title
    entity.address = place.address
    entity.city = place.city
    entity.latitude = place.latitude
    entity.longitude = place.longitude

    return entity
  }
}
