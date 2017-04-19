//
//  CreatorsViewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

final class CreatorsViewDisplayCollection: DisplayCollection {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [CreatorTableViewCellModel.self]
  }

  weak var delegate: DisplayCollectionDelegate?
  private var creators: [CreatorTableViewCellModel] = []

  enum `Type` {
    case creators
  }

  var sections: [Type] = [.creators]

  var numberOfSections: Int {
    return sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    return 10
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    switch sections[indexPath.section] {
    case .creators:
      let user = UserEntity.templateEntity
      return CreatorTableViewCellModel(creator: user)
    }
  }

  func didSelect(indexPath: IndexPath) {
    switch sections[indexPath.section] {
    case .creators:
      break
    }
  }
}
