//
//  TemplateTableCellViewModel.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 09/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct TemplateTableCellViewModel: CellViewModelType {
  typealias CellClass = UITableViewCell

  var message: String

  func setup(on cell: UITableViewCell) {
    cell.textLabel?.text = message
  }
}
