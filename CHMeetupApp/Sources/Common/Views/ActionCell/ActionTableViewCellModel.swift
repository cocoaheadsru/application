//
//  ActionTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 16/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct ActionTableViewCellModel {
  let text: String
  let imageName: String?
  let action: (() -> Void)?
}

extension ActionTableViewCellModel: CellViewModelType {
  func setup(on cell: ActionTableViewCell) {
    cell.descriptionActionLabel.text = text
    cell.isEnableForAction = action != nil

    if let imageName = imageName {
      cell.actionImageView.isHidden = false
      cell.actionImageView.image = UIImage(named: imageName)
    }
  }
}
