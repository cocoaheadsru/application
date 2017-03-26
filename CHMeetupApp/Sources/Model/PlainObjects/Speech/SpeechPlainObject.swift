//
//  SpeechPlainObject.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 26/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct SpeechPlainObject {
  let id: Int
  let title: String
  let description: String

  let speaker: UserPlainObject
  let content: [SpeechContentPlainObject]
}
