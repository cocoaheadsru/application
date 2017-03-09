//
//  PastEventsTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 10/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct PastEventsTableViewCellModel: CellViewModelType {
  typealias CellClass = PastEventsTableViewCell

  let event: EventEntity

  func setup(on cell: PastEventsTableViewCell) {
    cell.titleLabel.text = event.title
    // FIXME: - Right date
    cell.dateLabel.text = "01.02.2017"
  }
}
