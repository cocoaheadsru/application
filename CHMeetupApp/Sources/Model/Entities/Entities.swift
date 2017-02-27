//
//  Entities.swift
//  CHMeetupApp
//
//  Created by Igor Tudoran on 27.02.17.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation
import RealmSwift

class Social: Object {
  dynamic var socialID: Int = 0

  dynamic var name: String = ""

  let users = LinkingObjects(fromType: User.self, property: "social")

  override static func primaryKey() -> String? {
    return "socialID"
  }
}

class User: Object {
  dynamic var userID: Int = 0

  dynamic var name: String = ""
  dynamic var lastName: String = ""
  dynamic var secureParam: String = ""
  dynamic var photoURL: String = ""
  dynamic var isSpeaker: Bool = false

  dynamic var speaker: Speaker?
  dynamic var social: Social?

  override static func primaryKey() -> String? {
    return "userID"
  }
}

class Speaker: Object {
  dynamic var speakerID: Int = 0

  dynamic var name: String = ""
  dynamic var lastName: String = ""
  dynamic var photoURL: String = ""
  dynamic var phone: String = ""
  dynamic var email: String = ""
  dynamic var info: String = ""
  dynamic var company: String = ""

  let speaches = List<Speach>()
  let users = LinkingObjects(fromType: User.self, property: "speaker")

  override static func primaryKey() -> String? {
    return "speakerID"
  }
}

class Content: Object {
  dynamic var contentID: Int = 0

  dynamic var linkURL: String = ""
  dynamic var type: String = ""

  let speaches = LinkingObjects(fromType: Speach.self, property: "content")

  override static func primaryKey() -> String? {
    return "contentID"
  }
}

class Speach: Object {
  dynamic var speachID: Int = 0

  dynamic var title: String = ""
  dynamic var descriptionText: String = ""
  dynamic var imageURL: String = ""

  dynamic var content: Content?
  let speakers = LinkingObjects(fromType: Speaker.self, property: "speaches")
  let events = LinkingObjects(fromType: Event.self, property: "speaches")

  override static func primaryKey() -> String? {
    return "speachID"
  }
}

class Event: Object {
  dynamic var eventID: Int = 0

  dynamic var title: String = ""
  dynamic var date: Double = 0.0
  dynamic var hazQuiz: Bool = false

  let speaches = List<Speach>()
  let places = LinkingObjects(fromType: Place.self, property: "events")

  override static func primaryKey() -> String? {
    return "eventID"
  }
}

class Place: Object {
  dynamic var placeID: Int = 0

  dynamic var title: String = ""
  dynamic var address: String = ""

  let events = List<Event>()
  let cities = LinkingObjects(fromType: City.self, property: "places")

  override static func primaryKey() -> String? {
    return "placeID"
  }
}

class City: Object {
  dynamic var cityID: Int = 0
  dynamic var name: String = ""

  let places = List<Place>()

  override static func primaryKey() -> String? {
    return "cityID"
  }
}
