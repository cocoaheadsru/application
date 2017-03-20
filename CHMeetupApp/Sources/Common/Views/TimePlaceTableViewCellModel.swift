//
//  TimePlaceTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 20/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct TimePlaceTableViewCellModel {
  let time: String
  let place: String
}

extension TimePlaceTableViewCellModel: CellViewModelType {
  func setup(on cell: TimePlaceTableViewCell) {
    cell.timeLabel.text = time
    cell.placeLabel.text = place
  }
}
