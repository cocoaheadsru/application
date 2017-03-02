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

  let user = LinkingObjects(fromType: User.self, property: "social").first

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
  dynamic var email: String = ""
  dynamic var info: String = ""
  dynamic var company: String = ""
  let speaches = List<Speach>()

  let socials = List<Social>()

  override static func primaryKey() -> String? {
    return "userID"
  }
}

class Content: Object {
  dynamic var contentID: Int = 0

  dynamic var linkURL: String = ""
  dynamic var type: String = ""

  let speach = LinkingObjects(fromType: Speach.self, property: "contents").first

  override static func primaryKey() -> String? {
    return "contentID"
  }
}

class Speach: Object {
  dynamic var speachID: Int = 0

  dynamic var title: String = ""
  dynamic var descriptionText: String = ""
  dynamic var imageURL: String = ""

  let contents = List<Content>()
  let user = LinkingObjects(fromType: User.self, property: "speaches").first
  let event = LinkingObjects(fromType: Event.self, property: "speach").first

  override static func primaryKey() -> String? {
    return "speachID"
  }
}

class Event: Object {
  dynamic var eventID: Int = 0

  dynamic var title: String = ""
  dynamic var date: Double = 0.0

  let speaches = List<Speach>()

  override static func primaryKey() -> String? {
    return "eventID"
  }
}

class Place: Object {
  dynamic var placeID: Int = 0

  dynamic var title: String = ""
  dynamic var address: String = ""
  dynamic var city: String = ""

  override static func primaryKey() -> String? {
    return "placeID"
  }
}
