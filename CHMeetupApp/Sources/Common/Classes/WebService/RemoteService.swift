//
//  WebService.swift
//  CHMeetupApp
//
//  Created by Sam on 24/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

enum RemoteError: Error {
  case emptyResponse
  case notConnection
}

protocol RemoteProtocol {
  func load(_ api: API, completion: @escaping ([JSONDictionary]) -> Void) throws
}

final class RemoteService: RemoteProtocol {
  func load(_ api: API, completion: @escaping ([JSONDictionary]) -> Void) throws {
    if !Reachability.isInternetAvailable {
      throw RemoteError.notConnection
    }

    var request = URLRequest(url: api.queryURL)
    request.httpMethod = api.method
    request.httpBody = api.parameters?.httpQuery

    let loadSession = URLSession.shared.dataTask(with: request) { data, _, error in
      guard error == nil else {
        print("Sesion request error: \(error) for api resourse: \(api)")
        return
      }
      let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: [])
      guard let json = jsonObject as? [JSONDictionary] else { return }

      completion(json)
    }

    loadSession.resume()

  }
}
