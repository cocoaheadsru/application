//
//  RadioTableViewCell.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 08.03.17.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class RadioTableViewCell: UITableViewCell, RegistrationFieldCellProtocol {

  @IBOutlet weak var label: UILabel!

// MARK: - RegistrationFieldCellProtocol
  func setup(with item: FormFieldAnswer) {
    label.text = item.value
  }
}
