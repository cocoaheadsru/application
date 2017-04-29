//
//  ChooseProfilePhotoButton.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 29/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ChooseProfilePhotoButton: UIButton {

  @IBOutlet var backgroundButton: UIButton!
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var addImageView: UIImageView!

  var borderPhotoImageView: CAShapeLayer!
  var borderAddImageView: CAShapeLayer!
  var borderColor: UIColor!

  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    return self.loadFromNibIfEmbeddedInDifferentNib()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    let borderWidth = photoImageView.bounds.height * Constants.SystemSizes.imageViewBorderWidthPercentage
    borderPhotoImageView = photoImageView.getRoundWithBorder(borderWidth, color: borderColor)
    borderAddImageView = addImageView.getRoundWithBorder(borderWidth, color: borderColor)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    borderColor = .white
  }

  @IBAction func backgroundButtonPressedInside(_ sender: Any) {
    let newColor = borderColor.tapButtonChangeColor
    borderPhotoImageView.strokeColor = newColor.cgColor
    borderAddImageView.strokeColor = newColor.cgColor
    photoImageView.backgroundColor = newColor
    addImageView.backgroundColor = newColor
  }

  @IBAction func backgroundButtonPressedOutside(_ sender: Any) {
    borderPhotoImageView.strokeColor = borderColor.cgColor
    borderAddImageView.strokeColor = borderColor.cgColor
    photoImageView.backgroundColor = .clear
    addImageView.backgroundColor = borderColor
  }
}
