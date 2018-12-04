//
//  PlainObjectType.swift
//  CHMeetupApp
//
//  Created by Sam on 28/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

protocol PlainObjectType {
  init?(json: JSONDictionary)
}

extension Array where Element: PlainObjectType {
  init(json: [JSONDictionary]) {
    let value = json.compactMap(Iterator.Element.init)
    self = value
  }
}
