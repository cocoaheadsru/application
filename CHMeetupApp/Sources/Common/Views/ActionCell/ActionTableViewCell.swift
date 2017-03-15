//
//  ActionTableViewCell.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 15/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ActionTableViewCell: PlateTableViewCell {

  @IBOutlet var actionTypeImageView: UIImageView!
  @IBOutlet var hasActionImageView: UIImageView!

  @IBOutlet var descriptionActionLabel: UILabel! {
    didSet {
      descriptionActionLabel.font = UIFont.appFont(.gothamPro(size: 15))
    }
  }

    override func awakeFromNib() {
      super.awakeFromNib()
      roundType = .all
    }
}
