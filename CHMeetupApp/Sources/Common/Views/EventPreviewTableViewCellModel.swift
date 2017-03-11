//
//  EventPreviewTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct EventPreviewTableViewCellModel: CellViewModelType {
  typealias CellClass = EventPreviewTableViewCell

  let event: EventEntity

  func setup(on cell: EventPreviewTableViewCell) {
    cell.eventImageView.image = #imageLiteral(resourceName: "img_event_template")
    cell.nameAndDateLabel.text = event.title
    // FIXME: - Right date
    cell.placeLabel.text = "01.02.2017"
  }
}
