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
      return 2
    }
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    let type = sections[indexPath.section]
    switch type {
    case .speaker:
      let speaker = UserEntity()
      speaker.name = "Maxim"
      speaker.lastName = "Globak"
      speaker.company = "icnx.ru"
      speaker.position = "iOS Developer"
      speaker.photoURL = "https://pp.userapi.com/c628416/v628416674/3eb5e/cg35L651Jz8.jpg"
      return SpeakerTableViewCellModel(speaker: speaker) as CellViewAnyModelType
    case .speech:
      let speech = SpeechContentEntity()
      speech.id = 0
      speech.title = "Speech is great"
      return AboutSpeechTableViewCellModel(speech: speech)
    case .contentCells:
      let action = ActionPlainObject(text: "Goto nextline")
      return ActionTableViewCellModel(action: action)
    }
  }

  func didSelect(indexPath: IndexPath) {
    // Do stuff here ...
  }
}
