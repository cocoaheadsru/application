//
//  SpeakerTableViewCell.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 30.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class SpeakerTableViewCell: PlateTableViewCell {

  @IBOutlet var titleLabel: UILabel! {
    didSet {
      titleLabel.font = UIFont.appFont(.gothamProMedium(size: 15))
      titleLabel.textColor = UIColor(.gray)
      titleLabel.text = "Докладчик".localized
    }
  }

  @IBOutlet var avatarImageView: UIImageView! {
    didSet {
      avatarImageView.backgroundColor = UIColor(.darkGray)
      avatarImageView.clipsToBounds = true
    }
  }

  @IBOutlet var fullNameLabel: UILabel! {
    didSet {
      fullNameLabel.font = UIFont.appFont(.gothamProMedium(size: 17))
      fullNameLabel.textColor = UIColor(.darkGray)
    }
  }

  @IBOutlet var descriptionLabel: UILabel! {
    didSet {
      descriptionLabel.font = UIFont.appFont(.gothamPro(size: 15))
      descriptionLabel.textColor = UIColor(.darkGray)
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    avatarImageView.roundCorners()
  }
}
