//
//  Request.swift
//  CHMeetupApp
//
//  Created by Sam on 28/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

typealias RequestParams = [String: String]

enum RequestMethod {
  case get
  case post
  case head
  case delete

  var `string`: String {
    switch self {
    case .post:
      return "POST"
    case .head:
      return "HEAD"
    case .delete:
      return "DELETE"
    default:
      return "GET"
    }
  }
}

struct Request<T> {

  let base = "http://upapi.ru/method/"

  var query: String
  var params: RequestParams?
  var method: RequestMethod

  var parser: RequestContentParser<T>?

  var contentType = T.Type.self

  init(query: String,
       method: RequestMethod = .get,
       params: RequestParams? = nil,
       parser: RequestContentParser<T>? = nil) {
    self.query = query
    self.params = params
    self.method = method
    self.parser = parser
  }

}
