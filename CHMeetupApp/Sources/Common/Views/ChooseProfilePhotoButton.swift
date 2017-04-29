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
  var borderColor: UIColor = .white

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
  }

  @IBAction func backgroundButtonPressedInside(_ sender: Any) {
    borderPhotoImageView.strokeColor = borderColor.tapButtonChangeColor.cgColor
    borderAddImageView.strokeColor = borderColor.tapButtonChangeColor.cgColor
  }

  @IBAction func backgroundButtonPressedOutside(_ sender: Any) {
    borderPhotoImageView.strokeColor = borderColor.cgColor
    borderAddImageView.strokeColor = borderColor.cgColor
  }
}
