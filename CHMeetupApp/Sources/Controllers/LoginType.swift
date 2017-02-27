//
//  LoginType.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 27/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

enum LoginType {
  case vk
  case fb

  var title: String {
    switch self {
    case .vk:
      return "VK"
    case .fb:
      return "Facebook"
    }
  }

  var schemeAuth: URL? {
    let schemeAuthString: String
    switch self {
    case .vk:
      // swiftlint:disable:next line_length
      schemeAuthString = "vkauthorize://authorize?sdk_version=1.4.6&client_id=\(Constants.vkClientId)&scope=\(Constants.vkScope)&revoke=1&v=5.40"
    default:
      return nil
    }
    return URL(string: schemeAuthString)
  }

  var urlAuth: URL {
    let urlAuthString: String
    switch self {
    case .vk:
      // swiftlint:disable:next line_length
      urlAuthString = "https://oauth.vk.com/authorize?revoke=1&response_type=token&display=mobile&scope=\(Constants.vkScope)&v=5.40&redirect_uri=\(Constants.vkRedirect)&sdk_version=1.4.6&client_id=\(Constants.vkClientId)"
    case .fb:
      // swiftlint:disable:next line_length
      urlAuthString = "https://www.facebook.com/v2.8/dialog/oauth?client_id=\(Constants.fbClientId)&redirect_uri=\(Constants.fbRedirect)"
    }
    return URL(string: urlAuthString)!
  }

}
