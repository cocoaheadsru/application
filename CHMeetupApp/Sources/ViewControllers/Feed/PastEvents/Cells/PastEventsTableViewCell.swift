//
//  PastEventsTableViewCell.swift
//  CHMeetupApp
//
//  Created by Denis on 26.02.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class PastEventsTableViewCell: UITableViewCell {
  @IBOutlet fileprivate var titleLabel: UILabel!
  @IBOutlet fileprivate var dateLabel: UILabel!
  @IBOutlet fileprivate var placeholderImageView: UIImageView!
}

extension PastEventsTableViewCell {
  func configure(with item: PastEventsDisplayCollection.Item) {
    titleLabel.text = item.title
    dateLabel.text = item.dateTitle
  }
}
