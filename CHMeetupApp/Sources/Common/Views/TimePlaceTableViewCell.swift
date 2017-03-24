//
//  TimePlaceTableViewCell.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 20/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class TimePlaceTableViewCell: PlateTableViewCell {

  @IBOutlet var timeLabel: UILabel! {
    didSet {
      timeLabel.font = UIFont.appFont(.gothamPro(size: 15))
      timeLabel.textColor = UIColor(.darkGray)
    }
  }

  @IBOutlet var placeLabel: UILabel! {
    didSet {
      placeLabel.font = UIFont.appFont(.gothamPro(size: 15))
      placeLabel.textColor = UIColor(.darkGray)
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    roundType = .all
  }
}
