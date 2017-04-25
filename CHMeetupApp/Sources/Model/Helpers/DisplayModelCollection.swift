//
//  DisplayModelCollection.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 23/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

//инвалидная DisplayModelCollection 💩
struct DisplayModelCollection<T: TemplateEntity> where T: Object {

  private var modelCollection: DataModelCollection<T>!
  private var values: List<T>! = {
    var values = List<T>()
    Array(repeating: T.templateEntity, count: 5).forEach({
      values.append($0)
    })
    return values
  }()

  init(type: T.Type) {
    modelCollection = DataModelCollection(type: T.self)
    if modelCollection.count == 0 {
      isTemplate = true
    }
  }

  // MARK: - Properties

  var count: Int {
    return isTemplate ? values.count : modelCollection.count
  }

  var isTemplate: Bool = false

  // MARK: - Functionality

  private func objectAtIndex(index: Int) -> T {
    return isTemplate ? values[index] : modelCollection[index]
  }

  subscript(index: Int) -> T {
    return objectAtIndex(index: index)
  }
}
