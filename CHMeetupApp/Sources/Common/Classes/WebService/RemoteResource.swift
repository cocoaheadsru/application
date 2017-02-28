//
//  WebResource.swift
//  CHMeetupApp
//
//  Created by Sam on 24/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

typealias ResourceParams = [String: String]
typealias JSONDictionary = [String: Any]

enum Method {
  case get
  case post
  case delete
  var type: String {
    switch self {
    case .get:
      return "GET"
    case .delete:
      return "DELETE"
    default:
      return "POST"
    }
  }
}

class Resource<T> {
  private(set) var request: URLRequest?
  var parse: (Data) -> T?
  var params: ResourceParams?
  var method: Method = .get {
    didSet {
      self.request?.httpMethod = method.type
    }
  }

  // TODO: Write description

  // TODO: Replace clousare to initialize
  init(url: URL, query: String, params: ResourceParams?, parseItem: @escaping (Any) -> T?) {
    self.params = params
    self.parse = { data in
      let json = try? JSONSerialization.jsonObject(with: data, options: [])
      return json.flatMap(parseItem)
    }
    guard let requestURL = URL(string: url.absoluteString + query) else {
      print("Request failed, check base url and query for resourse: \(self)")
      return
    }
    self.setupRequest(url: requestURL)
  }

  func setupRequest(url: URL) {
    self.request = URLRequest(url: url)
    self.request?.httpMethod = method.type
    self.request?.httpBody = self.params?.httpQuery
  }
}
