//
//  API.swift
//  CHMeetupApp
//
//  Created by Sam on 25/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

typealias RequestParams = [String: String]

enum API {
  static let base: URL? = URL(string: "http://upapi.ru/method/")
  case users
  case userProfile(String)
  case events

  public var method: String {
    switch self {
    case .events:
      return "POST"
    default:
      return "GET"
    }
  }

  public var path: String {
    switch self {
    case .userProfile(let remoteID):
      return "users/\(remoteID)"
    case .users:
      return "users"
    default:
      return ""
    }
  }

  public var queryURL: URL {
    guard let url = API.base?.appendingPathComponent(self.path) else {
      print("Cannot create query url for: \(self)")
      return API.base!
    }
    return url
  }

  public var parameters: RequestParams? {
    switch self {
    case .users:
      return nil
    default:
      return nil
    }
  }
}
