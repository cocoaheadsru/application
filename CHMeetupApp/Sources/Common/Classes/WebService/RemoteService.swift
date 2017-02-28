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
}


typealias RequestParams = [String: String]

struct PORequest: POType {
  typealias RequestsEnum = RequestMethod

  var base = "https://upapi.ru/method/"
  
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
  
  var query: String
  var params: RequestParams?
  var method: RequestMethod
  
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
    static var list: PORequest {
      return PORequest(query: "users", params: nil)
    }
    
    
    static func auth(token: String, social_id: String) -> PORequest {
       return PORequest(query: "users", params: nil, method: .post)
    }
    
  }
  
  
  
}

enum RemoteError: Error {
  case emptyResponse
  case notConnection
}



class Server {
  static func request<T: POType>(_ request: PORequest, completion: (([T]) -> Void)?) {
    
    
    if !Reachability.isInternetAvailable {
      //throw RemoteError.notConnection
    }
    
    print(request)
    
//    let r = request as PORequest
//    
//    var request = URLRequest(url: r.base)
// 
//    request.httpMethod = r.
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
