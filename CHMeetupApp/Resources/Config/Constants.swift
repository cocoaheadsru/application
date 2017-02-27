//
//  Constants.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 27/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

// MARK: - Constants for project
final class Constants {
  static let vkClientId = "5894705"
  static let vkScope = "photos,wall,messages,friends,email,offline,nohttps,audio"
  static let vkRedirect = "vk\(Constants.vkClientId)://authorize"
  static let fbClientId = "612769202252885"
  static let fbRedirect = "fb\(Constants.fbClientId)://authorize"
}
