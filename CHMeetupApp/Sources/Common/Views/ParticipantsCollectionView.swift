//
//  PhotosPresentationView.swift
//  CHMeetupApp
//
//  Created by Dima on 16/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol PhotosPresentationViewDelegate: class {
  func participantsCollectionViewWillUpdateData(view: PhotosPresentationView)
}

class PhotosPresentationView: UIView {

  weak var delegate: PhotosPresentationViewDelegate?

  var imagesCollection: [UIImage] = [] {
    didSet {
      drawParticipants()
      delegate?.participantsCollectionViewWillUpdateData(view: self)
    }
  }

  // If participants collection view is empty
  var emptyImagesCollection: Bool {
    return self.imagesCollection.count == 0
  }

  open var borderColor: CGColor = UIColor.white.cgColor

  override func layoutSubviews() {
    super.layoutSubviews()

    drawParticipants()
  }

  private func drawParticipants() {
    for view in subviews {
      view.removeFromSuperview()
    }

    for (index, image) in imagesCollection.enumerated() {
      let viewHeight = bounds.height
      let viewWidth = bounds.width

      let xImageView = ((CGFloat(index) * viewHeight) * 0.8).round(0.5) // each new element takes 80% of view height
      let leadingEdgeSecondImageView = ((CGFloat(index + 1) * viewHeight) * 0.8) + viewHeight
      let borderWidth = viewHeight * Constants.SystemSizes.imageViewBorderWidthPercentage

      let imageView = UIImageView()
      imageView.backgroundColor = UIColor.white
      imageView.frame = CGRect(x: xImageView, y: 0.0, width: viewHeight, height: viewHeight)

      if (xImageView + viewHeight) <= viewWidth {
        imageView.image = image

        if leadingEdgeSecondImageView > viewWidth && imagesCollection.count > index {
          imageView.image = #imageLiteral(resourceName: "img_template_unknown")
        } else {
          imageView.roundWithWhiteBorder(borderWidth)
        }

        addSubview(imageView)
        sendSubview(toBack: imageView)
      } else { break }
    }
  }
}
