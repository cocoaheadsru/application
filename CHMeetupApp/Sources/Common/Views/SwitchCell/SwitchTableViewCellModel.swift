//
//  SwitchTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//
import UIKit

struct SwitchTableViewCellModel {
  let action: SwitchActionPlainObject
  weak var delegate: SwitchTableViewCellDelegate?
}

extension SwitchTableViewCellModel: CellViewModelType {
  func setup(on cell: SwitchTableViewCell) {
    cell.descriptionActionLabel.text = action.text

    if let imageName = action.imageName, let image = UIImage(named: imageName) {
      cell.actionImageView.image = image.imageWithTemplateRendingMode
      cell.actionImageView.isHidden = false
    } else {
      cell.actionImageView.isHidden = true
      cell.actionImageView.image = nil
    }

    cell.actionImageView.tintColor = UIColor(.darkGray)
    cell.switchView.isOn = action.isOn
    cell.delegate = delegate
  }

}
