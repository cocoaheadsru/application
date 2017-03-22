//
//  GiveSpeechDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 21/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class EventPreviewDisplayCollection: DisplayCollection {
  enum `Type` {
    case location
    case adress
    case speaches
    case description
    case additionalCells
  }

  var numberOfSections: Int {
    return sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    // FIXME: - return number of rows
    return 2
  }

  let sections: [Type] = [.location, .adress, .speaches, .description, .additionalCells]

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    // FIXME: - return needed cells and real data
    let type = sections[indexPath.section]
    switch type {
    case .location:
      return ActionTableViewCellModel(action: ActionPlainObject(handler: "Handler", imageName: "Image"))
    case .adress:
      return ActionTableViewCellModel(action: ActionPlainObject(handler: "Handler", imageName: "Image"))
    case .speaches:
      return ActionTableViewCellModel(action: ActionPlainObject(handler: "Handler", imageName: "Image"))
    case .description:
      return SpeachPreviewTableViewCellModel(firstName: "Alex",
                                             lastName: "Zimin",
                                             userPhoto: Data(),
                                             topic: "How to please Kirill",
                                             speachDescription: "Read his CV")
    case .additionalCells:
      return ActionTableViewCellModel(action: ActionPlainObject(handler: "Handler", imageName: "Image"))
    }
  }

  func didSelect(indexPath: IndexPath) {
    // TODO: - didSelect
  }
}
