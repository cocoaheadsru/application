//
//  ActionDetailIconCellModel.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 21/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import UIKit

struct ActionDetailIconCellModel {
  let action: ActionPlainObject
}

extension ActionDetailIconCellModel: CellViewModelType {

  func setup(on cell: ActionDetailIconCell) {
    cell.descriptionActionLabel.text = action.text
    cell.isEnableForAction = action.action != nil

    if let imageName = action.imageName, let image = UIImage(named: imageName) {
      cell.detailIconView.image = image.imageWithTemplateRendingMode
      cell.detailIconView.isHidden = false
    } else {
      cell.detailIconView.isHidden = true
      cell.detailIconView.image = nil
    }

    cell.detailIconView.tintColor = UIColor( action.isColorized ? .darkGray : .blue )
  }

}
