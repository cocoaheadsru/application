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

  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var addImageView: UIImageView!

  weak var delegate: ChooseProfilePhotoTableViewCellDelegate?

  @IBAction func chooseButtonAction(_ sender: Any) {
     delegate?.chooseProfilePhotoCellDidPressOnPhoto(self)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let borderWidth = photoImageView.bounds.height * Constants.SystemSizes.imageViewBorderWidthPercentage
    addImageView.roundWithWhiteBorder(borderWidth)
    photoImageView.roundWithWhiteBorder(borderWidth)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    contentView.backgroundColor = UIColor(.lightGray)
    selectionStyle = .none
  }
}
