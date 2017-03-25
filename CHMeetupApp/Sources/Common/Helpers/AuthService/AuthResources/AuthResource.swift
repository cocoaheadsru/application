//
//  AuthResource.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

typealias AuthResourceLoginCompletion = (_ token: String, _ key: String, _ error: Error?) -> Void

protocol AuthResource {
  //init(with token: String, secret key: String)
  func login(_ completion: AuthResourceLoginCompletion)
}
