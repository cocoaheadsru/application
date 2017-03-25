//
//  URL+Parameters.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension URL {
  var parameters: [String: String]? {
    var params: [String: String] = [:]
    let comonents = URLComponents(url: self, resolvingAgainstBaseURL: false)

    guard let fragment = comonents?.fragment else { return nil }

    let elements = fragment.components(separatedBy: "&")
    elements.forEach { (element) in
      let formant = element.components(separatedBy: "=")
      params[formant[0]] = formant[1]
    }

    return params
  }
}
