//
//  EventPreviewTableViewCell.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol EventPreviewTableViewCellDelegate: class {
  func eventCellAcceptButtonPressed(_ eventCell: EventPreviewTableViewCell)
}

class EventPreviewTableViewCell: PlateTableViewCell {

  var isEnabledForRegistration = false {
    didSet {
      goingButton.isHidden = !isEnabledForRegistration
    }
  }

  @IBOutlet var eventImageView: UIImageView!

  @IBOutlet var nameLabel: LoadingLabel! {
    didSet {
      nameLabel.font = UIFont.appFont(.avenirNextMedium(size: 18))
      nameLabel.textColor = UIColor(.strongGray)
    }
  }

  @IBOutlet var dateLabel: LoadingLabel! {
    didSet {
      dateLabel.font = UIFont.appFont(.avenirNextMedium(size: 16))
      dateLabel.textColor = UIColor(.strongGray)
    }
  }

  @IBOutlet var placeLabel: LoadingLabel! {
    didSet {
      placeLabel.font = UIFont.appFont(.avenirNextMedium(size: 16))
      placeLabel.textColor = UIColor(.strongGray)
    }
  }

  @IBOutlet var separationView: UIView! {
    didSet {
      separationView.backgroundColor = UIColor(.lightGray)
    }
  }

  @IBOutlet var participantsCollectionViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet var participantsCollectionViewTopConstraint: NSLayoutConstraint!

  @IBOutlet var participantsCollectionView: PhotosPresentationView!

  @IBOutlet var goingButton: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()

    participantsCollectionView.delegate = self

    roundType = .all
  }

  weak var delegate: EventPreviewTableViewCellDelegate?

  var parcicipantsHeight: CGFloat {
    // 36 paricipant view height, 12 is space from top
    return 48
  }

  var goingButtonHeight: CGFloat {
    // Button with spaces height
    return 64
  }

  @IBAction fileprivate func goingButtonAction(_ sender: Any) {
    delegate?.eventCellAcceptButtonPressed(self)
  }

  // Now would calculate manually
  override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                        verticalFittingPriority: UILayoutPriority) -> CGSize {
    var height: CGFloat = 270

    if isEnabledForRegistration == false {
      height -= goingButtonHeight
    }

    if participantsCollectionView.emptyImagesCollection {
      height -= parcicipantsHeight
      height -= separationView.frame.height
    }

    return CGSize(width: targetSize.width, height: height)
  }
}

extension EventPreviewTableViewCell: PhotosPresentationViewDelegate {
  func participantsCollectionViewWillUpdateData(view: PhotosPresentationView) {
    if view.emptyImagesCollection {
      separationView.isHidden = true
      participantsCollectionViewHeightConstraint.constant = 0
      participantsCollectionViewTopConstraint.constant = 0
    } else {
      participantsCollectionViewHeightConstraint.constant = 36
      participantsCollectionViewTopConstraint.constant = 12
    }
  }
}
