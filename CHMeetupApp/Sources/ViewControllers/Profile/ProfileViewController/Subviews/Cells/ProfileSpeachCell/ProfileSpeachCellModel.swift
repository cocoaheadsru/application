//
//  ProfileSpeachCellModel.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 22/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct ProfileSpeachCellModel {
  var description: String
}

extension ProfileSpeachCellModel: CellViewModelType {
  func setup(on cell: ProfileSpeachCell) {
    cell.speachDescriptionLabel.text = description
  }
}
