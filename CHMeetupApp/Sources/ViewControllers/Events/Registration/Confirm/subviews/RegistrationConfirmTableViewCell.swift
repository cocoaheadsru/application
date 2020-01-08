//
//  RegConfirmHeaderTableViewCell.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 24.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class RegConfirmHeaderTableViewCell: UITableViewCell {

  @IBOutlet var headerImageView: UIImageView! {
    didSet {
      headerImageView.layer.masksToBounds =  false
      headerImageView.layer.shadowColor = UIColor(.black).cgColor
      headerImageView.layer.shadowRadius = 40
      headerImageView.layer.shadowOpacity = 0.05
    }
  }

  @IBOutlet var label: UILabel! {
    didSet {
      label.font = UIFont.appFont(.avenirNextDemiBold(size: 16))
      label.textColor = UIColor.from(colorSet: .red)
      label.text = "Ваша заявка\nуспешно отправлена!".localized
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    contentView.backgroundColor = UIColor.from(colorSet: .background)
    selectionStyle = .none
  }
}
