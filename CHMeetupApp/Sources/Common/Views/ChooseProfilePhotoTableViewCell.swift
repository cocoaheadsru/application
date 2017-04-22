//
//  ChooseProfilePhotoTableViewCell.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol ChooseProfilePhotoTableViewCellDelegate: class {
  func chooseProfilePhotoCelldidPressOnPhoto(_ cell: ChooseProfilePhotoTableViewCell)
}

class ChooseProfilePhotoTableViewCell: UITableViewCell {

  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var addImageView: UIImageView!

  weak var delegate: ChooseProfilePhotoTableViewCellDelegate?

  @IBAction func chooseButtonAction(_ sender: Any) {
     delegate?.chooseProfilePhotoCelldidPressOnPhoto(self)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let borderWidth = photoImageView.bounds.height * 0.04
    addImageView.withWhiteRoundBorder(borderWidth)
    photoImageView.withWhiteRoundBorder(borderWidth)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    contentView.backgroundColor = UIColor(.lightGray)
    selectionStyle = .none
  }
}
