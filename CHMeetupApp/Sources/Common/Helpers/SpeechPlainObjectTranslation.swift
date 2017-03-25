//
//  SpeechPlainObjectTranslation.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 26/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct SpeechPlainObjectTranslation: PlainObjectTranslation {
  static func addToRealm(plainObject: SpeechPlainObject, to parent: EventEntity? = nil) {
    assert(parent != nil, "Parent should exist")

    let speakerPlainObject = plainObject.speaker

    let user = UserEntity()
    user.id = speakerPlainObject.id
    user.name = speakerPlainObject.name
    user.lastName = speakerPlainObject.lastname
    user.company = speakerPlainObject.company

    let speech = SpeechEntity()
    speech.id = plainObject.id
    speech.title = plainObject.title
    speech.descriptionText = plainObject.description

    // TODO: - Check is it okey
    user.speeches.append(speech)

    for contentPlainObject in plainObject.content {
      let content = SpeechContentEntity()
      content.id = contentPlainObject.id
      content.title = contentPlainObject.title
      content.descriptionText = contentPlainObject.description
      content.type = contentPlainObject.type
      content.linkURL = contentPlainObject.linkURL

      speech.contents.append(content)
    }

    realmWrite {
      mainRealm.add(user, update: true)
      parent?.speeches.append(speech)
    }
  }
}
