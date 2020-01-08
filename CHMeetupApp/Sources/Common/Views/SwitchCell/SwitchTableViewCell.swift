//
//  SwitchTableViewCell.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
  func switchTableViewCellDidChangeValue(_ switchCell: SwitchTableViewCell)
}

class SwitchTableViewCell: PlateTableViewCell {

  weak var delegate: SwitchTableViewCellDelegate?

  @IBOutlet var actionImageView: UIImageView! {
    didSet {
      actionImageView.isHidden = true
    }
  }

  @IBOutlet var descriptionActionLabel: UILabel! {
    didSet {
      descriptionActionLabel.font = UIFont.appFont(.avenirNextMedium(size: 16))
      descriptionActionLabel.textColor = UIColor.from(colorSet: .secondaryText)
    }
  }

  @IBOutlet var switchView: UISwitch!

  override func awakeFromNib() {
    super.awakeFromNib()
    roundType = .all
  }
  @IBAction func switchDidChangeValue(_ sender: Any) {
    delegate?.switchTableViewCellDidChangeValue(self)
  }
}
