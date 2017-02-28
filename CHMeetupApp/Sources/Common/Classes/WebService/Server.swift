//
//  WebService.swift
//  CHMeetupApp
//
//  Created by Sam on 24/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

enum ServerError: Error {
  case notConnection
  case requestFailed

  var desc: String {
    switch self {
    case .requestFailed:
      return "Неверно сформированный запрос"
    case .notConnection:
      return "Отстутствует подключение к сети"
    }
  }

}

class Server {
  static func request<T: POType>(_ request: Request<T>, completion: @escaping (([T]?, ServerError?) -> Void)) {

    if !Reachability.isInternetAvailable {
      completion(nil, .notConnection)
    }

    guard let query = URL(string: request.base + request.query) else {
      print("Session query url faild: base \(request.base) and query \(request.query)")
      completion(nil, .requestFailed)
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

      completion(objects, nil)

    }

    loadSession.resume()

  }
}
