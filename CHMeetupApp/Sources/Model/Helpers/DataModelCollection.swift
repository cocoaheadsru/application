//
//  DataModelCollection.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 05/03/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation
import RealmSwift

struct DataModelCollection<T: DataBasePlainObjectType> {
  private var results: Results<T.DataModelType>!

  init(type: T.Type) {
    results = mainRealm.objects(T.DataModelType.self)
  }

  // MARK: - Functionality

  func objectAtIndex(index: Int) -> T {
    return T.mapFromObject(object: results[index])
  }

  subscript(index: Int) -> T {
    get {
      return objectAtIndex(index: index)
    }
  }

  // MARK: - Filter

  func filter(_ predicateFormat: String, _ args: Any...) -> DataModelCollection<T> {
    var collection = self
    collection.results = collection.results?.filter(predicateFormat, args)
    return collection
  }

  // MARK: - Sort

  func sorted(byKeyPath keyPath: String, ascending: Bool = true) -> DataModelCollection<T> {
    var collection = self
    collection.results = collection.results?.sorted(byKeyPath: keyPath, ascending: ascending)
    return collection
  }
}
