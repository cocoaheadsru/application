//
//  Dictionary+Operations.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 14/08/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral, Value: ExpressibleByStringLiteral {

  static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
    rhs.forEach {
      lhs[$0] = $1
    }
  }

}
