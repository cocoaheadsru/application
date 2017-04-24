//
//  RegConfirmHeaderTableViewCell.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 24.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class RegConfirmHeaderTableViewCell: UITableViewCell {

  @IBOutlet var headerImageView: UIImageView!

  @IBOutlet var label: UILabel! {
    didSet {
      label.font = UIFont.appFont(.avenirNextDemiBold(size: 16))
      label.textColor = UIColor(.red)
      label.text = "Ваша заявка\nуспешно отправлена!".localized
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    contentView.backgroundColor = UIColor(.lightGray)
    selectionStyle = .none
  }
}
