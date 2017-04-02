//
//  SpeakerTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 02.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct SpeakerTableViewCellModel {
  let speaker: UserEntity
}

extension SpeakerTableViewCellModel: CellViewModelType {
  func setup(on cell: SpeakerTableViewCell) {
    cell.fullNameLabel.text = speaker.name + " " + speaker.lastName

    if let position = speaker.position, let company = speaker.company {
      let at = "at".localized
      let description =  position + " " + at + " " + company
      cell.descriptionLabel.text = description
    } else {
      cell.descriptionLabel.text = speaker.position ?? speaker.company
    }
  }
}
