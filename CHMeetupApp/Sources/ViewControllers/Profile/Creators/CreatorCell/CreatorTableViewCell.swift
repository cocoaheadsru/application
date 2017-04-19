//
//  CreatorTableViewCell.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class CreatorTableViewCell: PlateTableViewCell {

  @IBOutlet var creatorImage: UIImageView! {
    didSet {
      creatorImage.clipsToBounds = true
    }
  }
  @IBOutlet var creatorNameLabel: UILabel! {
    didSet {
      creatorNameLabel.font = UIFont.appFont(.avenirNextDemiBold(size: 18))
      creatorNameLabel.textColor = UIColor(.darkGray)
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
