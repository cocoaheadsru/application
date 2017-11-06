//
//  AlertHeaderTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 06/11/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct AlertHeaderTableViewCellModel: CellViewModelType {

  enum AlertHeaderTableViewCellType {
    case warning
    case danger
    case info

    var emoji: String {
      switch self {
      case .warning:
        return "🤔"
      case .danger:
        return "🔥"
      case .info:
        return "📌"
      }
    }
  }

  let alertType: AlertHeaderTableViewCellType
  let message: String

  func setup(on cell: AlertHeaderTableViewCell) {
    cell.alertEmoji.text = alertType.emoji
    cell.label.text = message
  }
}
