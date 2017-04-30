//
//  ChooseProfilePhotoButton.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 29/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ChooseProfilePhotoButton: UIButton {

  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet private var addImageView: UIImageView!

  var borderColor: UIColor!
  private var tappedColor: UIColor {
    return borderColor.tapButtonChangeColor
  }
  private var borderWidth: CGFloat {
    return photoImageView.bounds.height * Constants.SystemSizes.imageViewBorderWidthPercentage
  }
  private var isFirstSetup: Bool!

  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    return self.loadFromNibIfEmbeddedInDifferentNib()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    if isFirstSetup {
      photoImageView.roundWithBorder(borderWidth, color: borderColor)
      addImageView.roundWithBorder(borderWidth, color: borderColor)
      isFirstSetup = false
    }
    isHighlighted ? buttonTappedState() : buttonDefaultState()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    borderColor = .white
    isFirstSetup = true
  }

  private func buttonTappedState() {
    photoImageView.roundWithBorder(borderWidth, color: tappedColor)
    addImageView.roundWithBorder(borderWidth, color: tappedColor)
    photoImageView.backgroundColor = tappedColor
    addImageView.backgroundColor = tappedColor
  }

  private func buttonDefaultState() {
    photoImageView.removeRoundWithBorder(borderWidth, color: tappedColor)
    addImageView.removeRoundWithBorder(borderWidth, color: tappedColor)
    photoImageView.backgroundColor = .clear
    addImageView.backgroundColor = borderColor
  }

}
