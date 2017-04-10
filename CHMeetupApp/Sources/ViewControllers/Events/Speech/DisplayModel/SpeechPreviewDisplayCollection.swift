//
//  SpeechPreviewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 30.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class SpeechPreviewDisplayCollection: DisplayCollection {

  enum `Type` {
    case speaker
    case speech
    case contentCells
  }

  var speech: SpeechEntity?

  var sections: [Type] = [.speaker, .speech, .contentCells]

  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [SpeakerTableViewCellModel.self, AboutSpeechTableViewCellModel.self, ActionTableViewCellModel.self]
  }

  var numberOfSections: Int {
    return sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    switch sections[section] {
    case .speaker, .speech:
      return 1
    case .contentCells:
      return speech?.contents.count ?? 0
    }
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    let type = sections[indexPath.section]
    switch type {
    case .speaker:
      return SpeakerTableViewCellModel(speaker: speech?.user ?? UserEntity())
    case .speech:
      return AboutSpeechTableViewCellModel(speech: speech ?? SpeechEntity())
    case .contentCells:
      let actionPlainObject = ActionPlainObject(text: speech?.contents[indexPath.row].title ?? "",
                                                imageName: nil, action: { /* to do smth */ })
      return ActionTableViewCellModel(action: actionPlainObject)
    }
  }

  func didSelect(indexPath: IndexPath) {
    let type = sections[indexPath.section]
    switch type {
    case .speaker, .speech, .contentCells:
      break
    }
  }
}
