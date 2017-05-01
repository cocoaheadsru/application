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
  func templateModelCollectionDidUpdateData()
}

struct TemplateModelCollection<T: TemplateEntity> where T: Object {

  enum Content {
    case dataCollection(DataModelCollection<T>)
    case list(List<T>)
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
      delegate?.templateModelCollectionDidUpdateData()
    }
  }

  private var values: List<T>

  weak var delegate: TemplateModelCollectionDelegate?

  init(templatesCount: Int = 5) {
    content = Content.empty
    values = List<T>()
    generateFakeData(templatesCount: templatesCount)
  }

  init(dataCollection: DataModelCollection<T>, templatesCount: Int = 5) {
    content = Content.dataCollection(dataCollection)
    values = List<T>()
    generateFakeData(templatesCount: templatesCount)
  }

  init(list: List<T>, templatesCount: Int = 5) {
    content = Content.list(list)
    values = List<T>()
    generateFakeData(templatesCount: templatesCount)
  }

  private func generateFakeData(templatesCount: Int) {
    Array(repeating: T.templateEntity, count: templatesCount).forEach({
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
      delegate?.templateModelCollectionDidUpdateData()
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
