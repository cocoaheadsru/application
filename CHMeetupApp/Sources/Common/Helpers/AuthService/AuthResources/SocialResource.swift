//
//  SocialResource.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

typealias SocialResourceLoginCompletion = (_ token: String, _ key: String, _ error: Error?) -> Void

protocol SocialResource {
  //init(with app: String, secret key: String)
  func login(_ completion: SocialResourceLoginCompletion)
  var authURL: URL? { get }
  var appScheme: URL? { get }

  var appExists: Bool { get }
}

extension SocialResource {

  var appExists: Bool {
    guard let appScheme = self.appScheme else { return false }
    return UIApplication.shared.canOpenURL(appScheme)
  }

}
