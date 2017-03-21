//
//  ProfileSpeachCell.swift
//  CHMeetupApp
//
//  Created by Igor Tudoran on 25.02.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ProfileSpeachCell: UITableViewCell {

  @IBOutlet var speachDescriptionLabel: UILabel! {
    didSet {
      speachDescriptionLabel.font = UIFont.appFont(.systemFont(size: 15))
      speachDescriptionLabel.textColor = UIColor(.darkGray)
      speachDescriptionLabel.numberOfLines = 3
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}
