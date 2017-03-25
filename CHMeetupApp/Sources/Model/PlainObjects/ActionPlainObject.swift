//
//  ActionPlainObject.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 17/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct ActionPlainObject {
  var text: String
  var imageName: String?
  var action: (() -> Void)?

  init(text: String, imageName: String? = nil, action: (() -> Void)? = nil) {
    self.text = text
    self.imageName = imageName
    self.action = action
  }
}
