//
//  ActionDetailIconCell.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 21/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import UIKit

class ActionDetailIconCell: PlateTableViewCell {

  @IBOutlet var detailIconView: UIImageView! {
    didSet {
      detailIconView.isHidden = true
    }
  }

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
