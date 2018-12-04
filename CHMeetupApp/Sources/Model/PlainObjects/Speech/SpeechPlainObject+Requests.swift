//
//  SpeechPlainObject+Requests.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 26/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension SpeechPlainObject: PlainObjectType {

  struct Requests {

    // Speeches list
    static func speechesOnEvent(with id: Int) -> Request<[SpeechPlainObject]> {
      return Request(query: "speeches/event/\(id)")
    }
  }

  init?(json: JSONDictionary) {
    guard
      let id = json["id"] as? Int,
      let title = json["title"] as? String,
      let description = json["description"] as? String,
      let speakerJson = json["speaker"] as? JSONDictionary,
      let contentsJson = json["contents"] as? [JSONDictionary],
      let speaker = UserPlainObject(json: speakerJson)
      else { return nil }

    self.id = id
    self.title = title
    self.description = description
    self.speaker = speaker
    self.content = contentsJson.compactMap(SpeechContentPlainObject.init)

  }
}
