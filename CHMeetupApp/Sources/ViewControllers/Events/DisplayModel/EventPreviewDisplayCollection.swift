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

  func height(for indexPath: IndexPath) -> CGFloat {
    switch rows[indexPath.row] {
    case .eventName:
      return 74
    case .eventAddress:
      return 50
    case .eventDescription:
      return 221
    case .eventSpeaker:
      return 247
    }
  }

  let rows: [Type] = [.eventName, .eventAddress, .eventDescription, .eventSpeaker]

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    let type = rows[indexPath.row]
    switch type {
    case .eventName:
      return ProfileNameCell()
    case .eventAddress:
      return ProfileNameCell()
    case .eventDescription:
      return ProfileNameCell()
    case .eventSpeaker:
      return ProfileNameCell()
    }
  }
}
