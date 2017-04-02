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
    }
  }

  @IBOutlet var avatarImageView: UIImageView!
  
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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    roundType = .all
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    // Rounded avatar image
    avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.height / 2
  }
}
