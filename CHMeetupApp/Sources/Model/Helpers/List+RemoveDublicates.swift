//
//  List+RemoveDublicates.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 26/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

extension List {
  func removeDublicates<T: Hashable>(rule: ((_ element: Element) -> T)) {
    var identifiers = Set<T>()
    var dublicatesIndexes = [Int]()

    for (index, value) in self.enumerated() {
      let identifier = rule(value)

      if identifiers.contains(identifier) {
        dublicatesIndexes.append(index)
      } else {
        identifiers.insert(identifier)
      }
    }

    while dublicatesIndexes.count > 0 {
      let last = dublicatesIndexes.removeLast()
      remove(at: last)
    }
  }
}
