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

  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    return self.loadFromNibIfEmbeddedInDifferentNib()
  }

  override func layoutSubviews() {
    print("Layout")
    super.layoutSubviews()
    let borderWidth = photoImageView.bounds.height * Constants.SystemSizes.imageViewBorderWidthPercentage
    borderPhotoImageView = photoImageView.getRoundWithWhiteBorder(borderWidth)
    borderAddImageView = addImageView.getRoundWithWhiteBorder(borderWidth)
  }

  override func awakeFromNib() {
    print("Awakefromnib")
    super.awakeFromNib()
  }

  @IBAction func backgroundButtonPressed(_ sender: Any) {
    borderPhotoImageView.strokeColor = UIColor.black.cgColor
    borderAddImageView.strokeColor = UIColor.black.cgColor
  }
}
