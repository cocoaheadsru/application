//
//  RegistrationConfirmTableViewHeader.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 23.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class RegistrationConfirmTableViewHeader: UITableViewHeaderFooterView {
  
  @IBOutlet var imageView: UIImageView!
  
  @IBOutlet var label: UILabel! {
    didSet {
      label.text = "Ваша заявка/nуспешно отправлена!".localized
      label.textColor = UIColor(.red)
      label.font = UIFont.appFont(.avenirNextDemiBold(size: 16))
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = UIColor(.lightGray).withAlphaComponent(1.0)
  }
  
}
