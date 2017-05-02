//
//  ChooseProfilePhotoTableViewCell.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol ChooseProfilePhotoTableViewCellDelegate: class {
  func chooseProfilePhotoCellDidPressOnPhoto(_ cell: ChooseProfilePhotoTableViewCell)
}

class ChooseProfilePhotoTableViewCell: UITableViewCell {

  @IBOutlet var mainButton: ChooseProfilePhotoButton!

  weak var delegate: ChooseProfilePhotoTableViewCellDelegate?

  @IBAction func chooseButtonAction(_ sender: Any) {
     delegate?.chooseProfilePhotoCellDidPressOnPhoto(self)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = UIColor(.lightGray)
    selectionStyle = .none
  }
}
