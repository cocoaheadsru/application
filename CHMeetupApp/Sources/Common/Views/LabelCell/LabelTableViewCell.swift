//
//  LabelTableViewCell.swift
//  CHMeetupApp
//
//  Created by Sergey Zapuhlyak on 22/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

final class LabelTableViewCell: PlateTableViewCell {
  @IBOutlet var titleLabel: UILabel! {
    didSet {
      titleLabel.font = UIFont.appFont(.avenirNextDemiBold(size: 16))
      titleLabel.textColor = UIColor(.gray)
    }
  }

  @IBOutlet var descriptionLabel: UILabel! {
    didSet {
      descriptionLabel.font = UIFont.appFont(.avenirNextMedium(size: 16))
      descriptionLabel.textColor = UIColor(.black)
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    roundType = .all
  }
}
