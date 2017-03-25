//
//  FBResource.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

final class FBResource: SocialResource {

  fileprivate var token: String?
  fileprivate var secret: String?
  var appScheme = URL(string: "fb://")

  var authURL: URL? {
    var authString = "https://www.facebook.com/v2.8/dialog/oauth?client_id=\(Constants.Facebook.clientId)"
    authString += "&redirect_uri=\(Constants.Facebook.redirect)"
    return URL(string: authString)
  }

  func parameters(from url: URL) -> [String: String] {
    return [:]
  }
}
