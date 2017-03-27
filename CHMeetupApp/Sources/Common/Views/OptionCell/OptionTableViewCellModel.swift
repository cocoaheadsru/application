//
//  OptionTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Andrey Konstantinov on 16/03/17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct OptionTableViewCellModel {

  enum `Type` {
    case checkbox
    case radio
  }

  let id: Int
  let text: String
  let type: Type
  let result: Bool
}

extension OptionTableViewCellModel: CellViewModelType {

  func setup(on cell: OptionTableViewCell) {
    cell.setup(text: text, isRadio: type == .radio)
    cell.isSelected = result
    cell.updateSelection(shouldSelect: result)
  }

  func updateAppearance(of view: UIView, in parentView: UIView, at indexPath: IndexPath) {
    if let cell = view as? OptionTableViewCell,
      let tableView = parentView as? UITableView {
      cell.drawCorner(in: tableView, indexPath: indexPath)
    }
  }
}
