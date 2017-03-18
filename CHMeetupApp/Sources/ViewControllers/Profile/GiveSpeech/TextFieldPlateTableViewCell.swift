//
//  TextFieldPlateTableViewCell.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 18/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class TextFieldPlateTableViewCell: PlateTableViewCell {

  @IBOutlet var textField: UITextField!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}
