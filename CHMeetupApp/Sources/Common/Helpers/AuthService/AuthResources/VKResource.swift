//
//  VKResource.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

class VKResource: SocialResource {

  fileprivate var token: String?
  fileprivate var secret: String?
  var appScheme = URL(string: "vk://")

  var authURL: URL? {
    var authString: String
    if appExists {
      authString = "vkauthorize://authorize?sdk_version=1.4.6&client_id=\(Constants.Vkontakte.clientId)"
      authString += "&scope=\(Constants.Vkontakte.scope)&revoke=1&v=5.40"
    } else {
      authString = "https://oauth.vk.com/authorize?revoke=1&response_type=token&display=mobile"
      authString += "&scope=\(Constants.Vkontakte.scope)&v=5.40&redirect_uri=\(Constants.Vkontakte.redirect)"
      authString += "&sdk_version=1.4.6&client_id=\(Constants.Vkontakte.clientId)"
    }
    return URL(string: authString)
  }

  func login(_ completion: SocialResourceLoginCompletion) {
    completion("", "", nil)
  }

  func parameters(from url: URL) -> [String: String] {
    let parameters = url.parameters
    guard
      let token = parameters?["access_token"],
      let secret = parameters?["secret"]
    else { return [:] }
    return ["token": token, "secret": secret]
  }
}
