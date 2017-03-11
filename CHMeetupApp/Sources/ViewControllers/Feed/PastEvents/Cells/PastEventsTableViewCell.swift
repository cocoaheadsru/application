//
//  PastEventsTableViewCell.swift
//  CHMeetupApp
//
//  Created by Denis on 26.02.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class PastEventsTableViewCell: PlateTableViewCell {
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var placeholderImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    roundType = .allRounded
  }
}
