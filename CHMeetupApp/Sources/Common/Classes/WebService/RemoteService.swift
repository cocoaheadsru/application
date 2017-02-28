//
//  WebService.swift
//  CHMeetupApp
//
//  Created by Sam on 24/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

protocol POType {
  associatedtype RequestsEnum
  init?(json: [String: Any])
}

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
    default:
      return "GET"
    }
  }
}

struct Request<T> {
  var let = "http://upapi.ru/method/"

  var query: String
  var params: RequestParams?
  var method: RequestMethod

  var contentType = T.Type.self

  init(query: String, params: RequestParams?, method: RequestMethod) {
    self.query = query
    self.params = params
    self.method = method
  }

  init(query: String, params: RequestParams?) {
    self.query = query
    self.params = params
    self.method = .get
  }

}

struct UserPO: POType {
  typealias RequestsEnum = Requests
  struct Requests {
    static var list: Request<UserPO> {
      return Request(query: "users", params: nil)
    }

    static func auth(token: String, socialId: String) -> Request<UserPO> {
       return Request<UserPO>(query: "users", params: nil, method: .post)
    }

  }

  init?(json: [String : Any]) {

  }

}

enum RemoteError: Error {
  case emptyResponse
  case notConnection
}

class Server {
  static func request<T: POType>(_ request: Request<T>, completion: (([T]?) -> Void)?) {

    if !Reachability.isInternetAvailable {
      //throw RemoteError.notConnection
    }

    guard let query = URL(string: request.base + request.query) else {
      print("Session query url faild: base \(request.base) and query \(request.query)")
      return
    }
    var sessionRequest = URLRequest(url: query)

    sessionRequest.httpMethod = request.method.string
    sessionRequest.httpBody = request.params?.httpQuery
    let loadSession = URLSession.shared.dataTask(with: sessionRequest) { data, _, error in
      guard error == nil else {
        print("Session request error: \(error) for api resourse: \(request)")
        return
      }
      let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: [])
      guard let json = jsonObject as? [JSONDictionary] else { return }
      let objects: [T] = json.flatMap(T.init)
      guard let completion = completion else { return }
      completion(objects)

    }

    loadSession.resume()

  }
}

protocol RemoteProtocol {
  func load(_ api: API, completion: @escaping ([JSONDictionary]) -> Void) throws
}

final class RemoteService: RemoteProtocol {
  func load(_ api: API, completion: @escaping ([JSONDictionary]) -> Void) throws {
//    request.httpMethod = api.method
//    request.httpBody = api.parameters?.httpQuery
//
//    let loadSession = URLSession.shared.dataTask(with: request) { data, _, error in
//      guard error == nil else {
//        print("Sesion request error: \(error) for api resourse: \(api)")
//        return
//      }
//      let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: [])
//      guard let json = jsonObject as? [JSONDictionary] else { return }
//
//      completion(json)
//    }
//
//    loadSession.resume()

  }
}
