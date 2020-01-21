//
//  DefaultTableHeaderView.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 18/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class DefaultTableHeaderView: UITableViewHeaderFooterView {

  static let font = UIFont.appFont(.avenirNextDemiBold(size: 16))

  static var titleInsets: UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
  }

  @IBOutlet var headerLabel: UILabel! {
    didSet {
      headerLabel.font = DefaultTableHeaderView.font
      headerLabel.textColor = UIColor.from(colorSet: .secondaryText)
      headerLabel.layoutMargins = DefaultTableHeaderView.titleInsets
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = UIColor.from(colorSet: .background)
  }
}
