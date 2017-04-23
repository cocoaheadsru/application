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

}
