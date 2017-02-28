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

  struct Vkontakte {
    static let clientId = "5894705"
    static let scope = "photos,wall,messages,friends,email,offline,nohttps,audio"
    static let redirect = "vk\(clientId)://authorize"
  }

  struct Facebook {
    static let clientId = "612769202252885"
    static let redirect = "fb\(clientId)://authorize"
  }

  struct Twitter {

  }

}
