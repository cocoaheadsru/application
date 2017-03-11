//
//  EventPreviewTableViewCell.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class EventPreviewTableViewCell: UITableViewCell {

  @IBOutlet var eventImageView: UIImageView!
  @IBOutlet var nameAndDateLabel: UILabel!
  @IBOutlet var placeLabel: UILabel!

  @IBOutlet var separationView: UIView!
  @IBOutlet var goingButton: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  // Now would calculate manually
  override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                        verticalFittingPriority: UILayoutPriority) -> CGSize {
    return CGSize(width: targetSize.width, height: 270)
  }
}
