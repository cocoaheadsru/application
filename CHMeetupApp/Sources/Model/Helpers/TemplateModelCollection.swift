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

  enum Content {
    case dataCollection(model: DataModelCollection<T>)
    case list(list: List<T>)
    case empty

    var count: Int {
      switch self {
      case let .dataCollection(model):
        return model.count
      case let .list(list):
        return list.count
      case .empty:
        return 0
      }
    }

    subscript(index: Int) -> T {
      switch self {
      case let .dataCollection(model):
        return model[index]
      case let .list(list):
        return list[index]
      case .empty:
        return T.templateEntity
      }
    }
  }

  var content: Content {
    didSet {
      delegate?.templateModelCollectionReqestedVisualUpdate()
    }
  }

  private var values: List<T>

  weak var delegate: TemplateModelCollectionDelegate?

  init(fakeEntityCount: Int = 5) {
    content = Content.empty
    values = List<T>()
    generateFakeData(fakeEntityCount: fakeEntityCount)
  }

  init(dataCollection: DataModelCollection<T>, fakeEntityCount: Int = 5) {
    content = Content.dataCollection(model: dataCollection)
    values = List<T>()
    generateFakeData(fakeEntityCount: fakeEntityCount)
  }

  init(list: List<T>, fakeEntityCount: Int = 5) {
    content = Content.list(list: list)
    values = List<T>()
    generateFakeData(fakeEntityCount: fakeEntityCount)
  }

  private func generateFakeData(fakeEntityCount: Int) {
    Array(repeating: T.templateEntity, count: fakeEntityCount).forEach({
      values.append($0)
    })
  }

  // MARK: - Properties

  var count: Int {
    if isLoading && content.count == 0 {
      return values.count
    } else {
      return content.count
    }
  }

  var isLoading: Bool = false {
    didSet {
      delegate?.templateModelCollectionReqestedVisualUpdate()
    }
  }

  // MARK: - Functionality

  subscript(index: Int) -> T {
    if isLoading && content.count == 0 {
      return values[index]
    } else {
      return content[index]
    }
  }
}
