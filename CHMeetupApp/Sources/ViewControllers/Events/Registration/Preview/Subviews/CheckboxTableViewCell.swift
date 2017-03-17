//
//  CheckboxTableViewCell.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 08.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class CheckboxTableViewCell: UITableViewCell, RegistrationFieldCellProtocol {
  @IBOutlet weak var label: UILabel!

// MARK: - RegistrationFieldCellProtocol
  func setup(with item: FormFieldAnswer) {
    label.text = item.value
  }
}
