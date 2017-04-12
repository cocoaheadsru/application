//
//  RequestPlainObject.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 05/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct RequestPlainObject {

  let success: Bool
  let answer: String
  let code: Int

  let error: RequestError?
}
