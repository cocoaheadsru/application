//
//  WebService.swift
//  CHMeetupApp
//
//  Created by Sam on 24/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

protocol Remote {
  func load<T>(resourse: Resource<T>, completion: @escaping (T?) -> (Void)) throws
}

enum RemoteError: Error {
  case emptyResponse
  case notConnection
}

final class RemoteService: Remote {
  func load<T>(resourse: Resource<T>, completion: @escaping (T?) -> (Void)) throws {
    if !Reachability.isInternetAvailable {
      throw RemoteError.notConnection
    }

    let loadSession = URLSession.shared.dataTask(with: resourse.request!) { data, _, error in
      guard error == nil else {
        print("Sesion request error: \(error) for resource: \(resourse)")
        return
      }
      let result = data.flatMap(resourse.parse)
      completion(result)
    }
    loadSession.resume()
  }
}
