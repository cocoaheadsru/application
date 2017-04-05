//
//  DataModelCollection.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 05/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

struct DataModelCollection<T: Object> {
  private var results: Results<T>!

  init(type: T.Type) {
    results = mainRealm.objects(T.self)
  }

  // MARK: - Properties

  var count: Int {
    return results.count
  }

  // MARK: - Functionality

  private func objectAtIndex(index: Int) -> T {
    return results[index]
  }

  subscript(index: Int) -> T {
    return objectAtIndex(index: index)
  }

  // MARK: - Filter

  mutating func filter(_ predicateFormat: String, _ args: Any...) {
    results = results.filter(predicateFormat, args)
  }

  func filtered(_ predicateFormat: String, _ args: Any...) -> DataModelCollection<T> {
    var collection = self
    collection.filter(predicateFormat, args)
    return collection
  }

  mutating func filter(_ predicate: NSPredicate) {
    results = results.filter(predicate)
  }

  func filtered(_ predicate: NSPredicate) -> DataModelCollection<T> {
    var collection = self
    collection.filter(predicate)
    return collection
  }

  // MARK: - Sort

  mutating func sort(byKeyPath keyPath: String, ascending: Bool = true) {
    results = results.sorted(byKeyPath: keyPath, ascending: ascending)
  }

  func sorted(byKeyPath keyPath: String, ascending: Bool = true) -> DataModelCollection<T> {
    var collection = self
    collection.sort(byKeyPath: keyPath, ascending: ascending)
    return collection
  }

  // MARK: - Search

  func first(where predicate: (T) -> Bool) -> T? {
    return results.first(where: predicate)
  }
}
