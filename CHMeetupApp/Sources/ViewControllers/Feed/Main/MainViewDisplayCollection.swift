//
//  MainViewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 24/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct MainViewDisplayCollection: DisplayCollection {

  enum `Type` {
    case events
    case actionButtons
  }

  var sections: [Type] = [.events, .actionButtons]

  let modelCollection = DataModelCollection(type: EventEntity.self).filtered("startDate > \(Date())")

  var numberOfSections: Int {
    return 2
  }

  func numberOfRows(in section: Int) -> Int {
    switch sections[section] {
    case .events:
      return modelCollection.count
    case .actionButtons:
      return 1
    }
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    switch sections[indexPath.section] {
    case .events:
      let model = EventPreviewTableViewCellModel(event: modelCollection[indexPath.row], index: indexPath.row)
      return model
    case .actionButtons:
      let model = ActionTableViewCellModel(text: "Example".localized, imageName: nil, action: nil)
      return model
    }

  }
}
