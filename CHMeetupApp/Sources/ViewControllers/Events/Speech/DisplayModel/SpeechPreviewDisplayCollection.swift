//
//  SpeechPreviewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 30.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol SpeechPreviewDisplayCollectionDelegate: class {
  func displayCollectionRequestingUIUpdate()
}

class SpeechPreviewDisplayCollection: DisplayCollection {

  enum `Type` {
    case speaker
    case speech
    case additionalCells
  }

  // Uncomment with all cells
  //  var sections: [Type] = [.speaker, .speech, .additionalCells]
  var sections: [Type] = [.speaker]

  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [SpeakerTableViewCellModel.self]
  }

  var numberOfSections: Int {
    return sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    switch sections[section] {
    case .speaker, .speech:
      return 1
    case .additionalCells:
      return 2
    }
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    let speaker = UserEntity()
    speaker.name = "Maxim"
    speaker.lastName = "Globak"
    speaker.company = "icnx.ru"
    speaker.position = "iOS Developer"
    speaker.photoURL = "https://pp.userapi.com/c628416/v628416674/3eb5e/cg35L651Jz8.jpg"

    return SpeakerTableViewCellModel(speaker: speaker) as CellViewAnyModelType
  }
}
