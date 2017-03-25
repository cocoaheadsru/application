//
//  VKResource.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

class VKResource: AuthResource {
  func login(_ completion: AuthResourceLoginCompletion) {
    completion("", "", nil)
  }

  fileprivate var token: String?
  fileprivate var secret: String?

  //required init(with token: String, secret key: String) {
    //self.token = token
    //self.secret = key
  //}
}
