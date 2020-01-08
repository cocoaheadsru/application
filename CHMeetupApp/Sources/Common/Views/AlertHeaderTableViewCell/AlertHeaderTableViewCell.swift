//
//  AlertHeaderTableViewCell.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 06/11/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class AlertHeaderTableViewCell: UITableViewCell {

  @IBOutlet var alertEmoji: UILabel! {
    didSet {
      alertEmoji.font = UIFont.appFont(.avenirNextDemiBold(size: 76))
    }
  }

  @IBOutlet var label: UILabel! {
    didSet {
      label.font = UIFont.appFont(.avenirNextDemiBold(size: 16))
      label.textColor = UIColor.from(colorSet: .secondaryText)
      label.text = "Ваша заявка\nуспешно отправлена!".localized
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    selectionStyle = .none
  }
}
