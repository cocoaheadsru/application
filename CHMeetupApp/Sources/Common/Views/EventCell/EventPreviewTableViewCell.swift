//
//  EventPreviewTableViewCell.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class EventPreviewTableViewCell: PlateTableViewCell {

  var isEnabledForRegistration = false {
    didSet {
      goingButton.isHidden = !isEnabledForRegistration
    }
  }

  @IBOutlet var eventImageView: UIImageView!

  @IBOutlet var nameLabel: UILabel! {
    didSet {
      nameLabel.font = UIFont.appFont(.gothamPro(size: 17))
    }
  }

  @IBOutlet var dateLabel: UILabel! {
    didSet {
      dateLabel.font = UIFont.appFont(.gothamPro(size: 15))
    }
  }

  @IBOutlet var placeLabel: UILabel! {
    didSet {
      placeLabel.font = UIFont.appFont(.gothamPro(size: 15))
    }
  }

  @IBOutlet var separationView: UIView! {
    didSet {
      separationView.backgroundColor = UIColor(.lightGray)
    }
  }

  @IBOutlet var participantsCollectionViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet var participantsCollectionViewTopConstraint: NSLayoutConstraint!
  
  @IBOutlet var participantsCollectionView: ParticipantsCollectionView!

  @IBOutlet var goingButton: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()

    participantsCollectionView.delegate = self

    roundType = .all
  }

  var parcicipantsHeight: CGFloat {
    return 36 + 12
  }

  var goingButtonHeight: CGFloat {
    return 64
  }

  // Now would calculate manually
  override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                        verticalFittingPriority: UILayoutPriority) -> CGSize {
    var height: CGFloat = 266

    if isEnabledForRegistration == false {
      height -= goingButtonHeight
    }

    if participantsCollectionView.imagesCollection.count == 0 {
      height -= parcicipantsHeight
    }

    return CGSize(width: targetSize.width, height: height)
  }
}

extension EventPreviewTableViewCell: ParticipantsCollectionViewDelegate {
  func participantsCollectionViewWillUpdateData(view: ParticipantsCollectionView) {
    participantsCollectionViewHeightConstraint.constant = view.imagesCollection.count == 0 ? 0 : 36
    participantsCollectionViewTopConstraint.constant = view.imagesCollection.count == 0 ? 0 : 12
  }
}
