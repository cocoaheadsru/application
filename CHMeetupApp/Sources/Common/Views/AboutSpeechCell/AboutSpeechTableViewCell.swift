//
//  AboutSpeechTableViewCell.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 29/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class AboutSpeechTableViewCell: PlateTableViewCell {

  @IBOutlet var infoLabel: UILabel! {
    didSet {
      infoLabel.font = UIFont.appFont(.avenirNextDemiBold(size: 16))
      infoLabel.textColor = UIColor.from(colorSet: .secondaryText)
    }
  }
  @IBOutlet var titleLabel: UILabel! {
    didSet {
      titleLabel.font = UIFont.appFont(.avenirNextDemiBold(size: 18))
      titleLabel.textColor = UIColor.from(colorSet: .secondaryText)
    }
  }
  @IBOutlet var descriptionLabel: UILabel! {
    didSet {
      descriptionLabel.font = UIFont.appFont(.avenirNextMedium(size: 16))
      descriptionLabel.textColor = UIColor.from(colorSet: .primaryText)
    }
  }
}
