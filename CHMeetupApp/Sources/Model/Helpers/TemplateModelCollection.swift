//
//  TemplateModelCollection.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 23/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

protocol TemplateModelCollectionDelegate: class {
  func templateModelCollectionReqestedVisualUpdate()
}

struct TemplateModelCollection<T: TemplateEntity> where T: Object {

  var dataCollection: DataModelCollection<T>
  private var values: List<T>

  weak var delegate: TemplateModelCollectionDelegate?

  init(dataCollection: DataModelCollection<T>, fakeEntityCoiunt: Int = 5) {
    self.dataCollection = dataCollection
    values = List<T>()
    Array(repeating: T.templateEntity, count: 5).forEach({
      values.append($0)
    })
  }

  // MARK: - Properties

  var count: Int {
    return isLoading ? values.count : dataCollection.count
  }

  var isLoading: Bool = false {
    didSet {
      delegate?.templateModelCollectionReqestedVisualUpdate()
    }
  }

  // MARK: - Functionality

  private func objectAtIndex(index: Int) -> T {
    return isLoading ? values[index] : dataCollection[index]
  }

  subscript(index: Int) -> T {
    return objectAtIndex(index: index)
  }
}
