//
//  FormPlateTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 22.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct FormPlateTableViewCellModel {
  let title: String
}

extension FormPlateTableViewCellModel: CellViewModelType {
  func setup(on cell: UITableViewCell) {
    cell.textLabel?.text = title
  }
}
