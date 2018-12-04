//
//  ActionTableViewCell.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 15/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ActionTableViewCell: PlateTableViewCell {

  var isEnableForAction = false {
    didSet {
      enableImageView.isHidden = !isEnableForAction
      let traits = super.accessibilityTraits
      let rawValue = traits.rawValue | (UIAccessibilityTraits.button.rawValue * (isEnableForAction ? 1 : 0))
      accessibilityTraits = UIAccessibilityTraits(rawValue: rawValue)
    }
  }

  @IBOutlet var actionImageView: UIImageView! {
    didSet {
      actionImageView.isHidden = true
    }
  }

  @IBOutlet var enableImageView: UIImageView!

  @IBOutlet var descriptionActionLabel: UILabel! {
    didSet {
      descriptionActionLabel.font = UIFont.appFont(.avenirNextMedium(size: 16))
      descriptionActionLabel.textColor = UIColor(.darkGray)
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    roundType = .all
  }
}
