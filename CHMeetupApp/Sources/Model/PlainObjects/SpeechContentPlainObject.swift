//
//  SpeechContentPlainObject.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 26/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct SpeechContentPlainObject {

  enum SpeechContentType: String {
    case video
    case slide
    case unknown
  }

  let id: Int

  let title: String
  let description: String

  let linkURL: URL
  let type: SpeechContentType
}
