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
    case eventName
    case eventAddress
    case eventDescription
    case eventSpeaker
  }

  var numberOfSections: Int {
    return 1
  }

  func numberOfRows(in section: Int) -> Int {
    return 4
  }

  let rows: [Type] = [.eventName, .eventAddress, .eventDescription, .eventSpeaker]

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    // FIXME: - return needed cells and real data
    let type = rows[indexPath.row]
    switch type {
    case .eventName:
      return ActionTableViewCellModel(action: ActionPlainObject(handler: "Handler", imageName: "Image"))
    case .eventAddress:
      return ActionTableViewCellModel(action: ActionPlainObject(handler: "Handler", imageName: "Image"))
    case .eventDescription:
      return ProfileSpeachCellModel(description: "Hello everyone")
    case .eventSpeaker:
      return SpeachPreviewTableViewCellModel(firstName: "Alex",
                                             lastName: "Zimin",
                                             userPhoto: Data(),
                                             topic: "Hernya",
                                             speachDescription: "Lolka")
    }
  }
}
