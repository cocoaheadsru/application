//
//  EventPO+Requests.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 03/03/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

extension EventPo: POType {

  struct Requests {
    // Events list
    static var list: Request<[EventPo]> {
      return Request(query: "events")
    }
  }

  init?(json: JSONDictionary) {
    guard
      let id = json["id"] as? Int,
      let title = json["title"] as? String,
      let desc = json["description"] as? String,
      let date = json["date"] as? Double,
      let placeJson = json["place"] as? JSONDictionary,
      let place = PlacePO(json: placeJson)
      else { return nil }

    self.eventID = id
    self.title = title
    self.desc = desc
    self.place = place
    self.date = Date.init(timeIntervalSince1970: date)
  }
}
